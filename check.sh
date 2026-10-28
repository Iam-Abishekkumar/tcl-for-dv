#!/usr/bin/env bash
# check.sh: run every published exercise and compare it with its saved real output (<name>.out).
#
#   ./check.sh                    check all published exercises (GitHub Actions runs exactly this)
#   ./check.sh path/to/file       check only these files
#   ./check.sh --update FILE...   run FILE and (re)write FILE's .out (look at the result before committing)
#
# How a file is run comes from its header comments:
#   # Run: <command>     one line per run (default: tclsh the file)
#   # Setup: <command>   runs first, to create input files
#   # Mask: <regex>      parts that change every run (like a process ID) are ignored
# Each file runs in a temporary copy of its folder, so nothing in the repo changes.

set -u
export LC_ALL=C
EXT=tcl
ROOT=$(cd "$(dirname "$0")" && pwd)
cd "$ROOT"

UPDATE=0
[ "${1:-}" = "--update" ] && { UPDATE=1; shift; }
if [ $# -gt 0 ]; then
  files=("$@")
else
  mapfile -t files < <(find . -path ./queue -prune -o -path ./.git -prune -o -name "*.$EXT" -print | sed 's#^\./##' | sort)
fi

if [ -t 1 ] || [ -n "${CI:-}" ]; then G=$'\e[32m'; R=$'\e[31m'; Y=$'\e[33m'; N=$'\e[0m'; else G=; R=; Y=; N=; fi

run_file() {  # file -> prints the transcript of all its runs
  local f=$1 dir base runs setup tmp
  dir=$(dirname "$f"); base=$(basename "$f")
  runs=$(sed -n '1,25s/^# Run: //p' "$f")
  [ -n "$runs" ] || runs="tclsh @FILE@"
  runs=${runs//@FILE@/$base}
  setup=$(sed -n '1,25s/^# Setup: //p' "$f")
  tmp=$(mktemp -d)
  cp -R "$dir/." "$tmp/"
  chmod u+x "$tmp"/*.sh 2>/dev/null
  (
    cd "$tmp" || exit 1
    export HOME="$tmp"
    [ -n "$setup" ] && bash -c "$setup" >/dev/null 2>&1
    while IFS= read -r r; do
      echo "\$ $r"
      bash -c "$r" < /dev/null 2>&1
    done <<< "$runs"
  )
  rm -rf "$tmp"
}

masked() {  # mask-regex text
  if [ -n "$1" ]; then sed -E "s/$1/N/g" <<< "$2"; else printf '%s\n' "$2"; fi
}

pass=0; fail=0
dtmp=$(mktemp)
trap 'rm -f "$dtmp"' EXIT
for f in "${files[@]}"; do
  out="${f%.*}.out"
  if [ "$UPDATE" -eq 0 ] && [ ! -f "$out" ]; then
    continue                                   # helper files (like config.sh) have no saved output
  fi
  actual=$(run_file "$f")
  if [ "$UPDATE" -eq 1 ]; then
    printf '%s\n' "$actual" > "$out"
    printf '%sSAVED%s %s\n' "$Y" "$N" "$out"
    continue
  fi
  mask=$(sed -n '1,25s/^# Mask: //p' "$f")
  if diff -u --label "saved: $out" --label "now" <(masked "$mask" "$(cat "$out")") <(masked "$mask" "$actual") > "$dtmp"; then
    printf '%sPASS%s  %s\n' "$G" "$N" "$f"; pass=$((pass + 1))
  else
    printf '%sFAIL%s  %s\n' "$R" "$N" "$f"; sed 's/^/      /' "$dtmp"; fail=$((fail + 1))
  fi
done

[ "$UPDATE" -eq 1 ] && exit 0
echo "----------------------------------------"
if [ $((pass + fail)) -eq 0 ]; then
  echo "No exercises published yet."
elif [ "$fail" -eq 0 ]; then
  printf '%sAll %d checked files match their saved output.%s\n' "$G" "$pass" "$N"
else
  printf '%s%d of %d checked files do not match.%s\n' "$R" "$fail" "$((pass + fail))" "$N"
  exit 1
fi
