#!/usr/bin/env bash
# push_to_github.sh: publish one of your practice repos to GitHub.
# Works for linux-cli-for-dv, vim-for-dv and git-for-dv (and is safe to re-run after every change).
#
# Usage:
#   bash push_to_github.sh <github-username> [options]
#
# Examples:
#   bash push_to_github.sh abishek                                    # linux-cli-for-dv
#   bash push_to_github.sh abishek --repo vim-for-dv                  # vim-for-dv
#   bash push_to_github.sh abishek --repo vim-for-dv -m "Solve 05"    # after solving a problem
#   bash push_to_github.sh abishek --repo git-for-dv                  # git-for-dv (first push)
#
# Options:
#   --repo NAME       GitHub repository name        (default: linux-cli-for-dv)
#   --dir PATH        local repo folder              (default: ./NAME, or unzips NAME.zip)
#   --ssh             push over SSH (git@github.com:...) instead of HTTPS
#   --no-gh           don't use the GitHub CLI even if it is installed
#   -m, --message M   commit message
#
# What it does:
#   1. finds (or unzips) the repo folder
#   2. puts your username into the README badge and links
#   3. runs the repo's own checks and refuses to push if anything FAILS
#   4. commits on branch main
#   5. creates the GitHub repo (with the gh CLI) or asks you to create it on github.com
#   6. pushes and prints the links

set -euo pipefail

REPO="linux-cli-for-dv"
DIR=""; GH_USER=""; USE_SSH=0; USE_GH=1; MSG=""
PLACEHOLDER="Iam-Abishekkumar"

if [ -t 1 ]; then G=$'\e[32m'; R=$'\e[31m'; Y=$'\e[33m'; B=$'\e[1m'; N=$'\e[0m'; else G=; R=; Y=; B=; N=; fi
step() { printf '\n%s==> %s%s\n' "$B" "$*" "$N"; }
ok()   { printf '%s    ok%s  %s\n' "$G" "$N" "$*"; }
warn() { printf '%s    !%s   %s\n' "$Y" "$N" "$*"; }
die()  { printf '%sERROR:%s %s\n' "$R" "$N" "$*" >&2; exit 1; }
is_repo() { [ -f "$1/run_regression.sh" ] || [ -f "$1/check.sh" ]; }

# ------------------------------------------------------------------ arguments
while [ $# -gt 0 ]; do
  case "$1" in
    --repo)       REPO="${2:?--repo needs a name}"; shift 2 ;;
    --dir)        DIR="${2:?--dir needs a path}"; shift 2 ;;
    --ssh)        USE_SSH=1; shift ;;
    --no-gh)      USE_GH=0; shift ;;
    -m|--message) MSG="${2:?--message needs text}"; shift 2 ;;
    -h|--help)    sed -n '2,28p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*)           die "unknown option $1 (see --help)" ;;
    *)            GH_USER="$1"; shift ;;
  esac
done

if [ -z "$GH_USER" ]; then
  read -r -p "GitHub username: " GH_USER
fi
[[ "$GH_USER" =~ ^[A-Za-z0-9-]+$ ]] || die "'$GH_USER' is not a valid GitHub username"
[[ "$REPO" =~ ^[A-Za-z0-9._-]+$ ]]  || die "'$REPO' is not a valid repository name"

command -v git >/dev/null || die "git is not installed. Install it with: sudo apt install git"

# ------------------------------------------------------------------ 1. find the repo folder
step "1/6  Locating the repo folder"
if [ -z "$DIR" ]; then
  if   [ "$(basename "$(pwd)")" = "$REPO" ] && is_repo .; then DIR="."
  elif [ -d "./$REPO" ];      then DIR="./$REPO"
  elif [ -f "./$REPO.zip" ];  then
    command -v unzip >/dev/null || die "unzip is not installed. Install it with: sudo apt install unzip"
    unzip -q "./$REPO.zip" -d . && DIR="./$REPO" && ok "unzipped $REPO.zip"
  elif is_repo .;             then DIR="."
  else
    die "can't find $REPO. Run this next to $REPO.zip, or inside the folder, or pass --dir PATH"
  fi
fi
is_repo "$DIR" || die "$DIR does not look like a practice repo (no run_regression.sh or check.sh)"
cd "$DIR"
ok "using $(pwd)"

if [ -f .github/repo-about ]; then
  DESC=$(sed -n 1p .github/repo-about)
  read -r -a TOPICS <<< "$(sed -n 2p .github/repo-about)"
else
  DESC="Linux CLI exercises (grep, sort, uniq, find, cut, sed, awk) verified like a DV regression: golden outputs + CI"
  TOPICS=(design-verification linux bash awk sed grep regression-testing uvm)
fi

# ------------------------------------------------------------------ 2. personalise README
step "2/6  Putting your username into the README links"
files=$(grep -rlI --exclude-dir=.git -- "$PLACEHOLDER" . || true)
if [ -n "$files" ]; then
  echo "$files" | xargs sed -i "s/$PLACEHOLDER/$GH_USER/g"
  ok "replaced placeholder in: $(echo "$files" | tr '\n' ' ')"
else
  ok "already personalised"
fi
FOLDER=$(basename "$(pwd)")
if [ "$REPO" != "$FOLDER" ]; then
  { grep -rlI --exclude-dir=.git -- "github.com/$GH_USER/$FOLDER" . || true; } | xargs -r sed -i "s#github.com/$GH_USER/$FOLDER#github.com/$GH_USER/$REPO#g"
  ok "links now point to $GH_USER/$REPO"
fi

# ------------------------------------------------------------------ 3. checks gate
step "3/6  Running the repo's checks (nothing is pushed if something FAILS)"
chmod +x ./*.sh exercises/*/*.sh 2>/dev/null || true
if [ -f run_regression.sh ]; then CHECK=./run_regression.sh; else CHECK=./check.sh; fi
KIND=$(sed -n 's/^# //p' README.md 2>/dev/null | head -n 1)
[ -n "$KIND" ] || KIND="practice exercises"
if bash $CHECK; then
  ok "checks passed"
else
  die "a check failed: fix the FAIL above before pushing"
fi

# ------------------------------------------------------------------ 4. commit
step "4/6  Committing"
if [ -z "$(git config user.name || true)" ]; then
  read -r -p "Your name for commits (e.g. Abishek Kumar): " name
  git config --global user.name "$name"
fi
if [ -z "$(git config user.email || true)" ]; then
  read -r -p "Your email for commits (use the one on your GitHub account): " email
  git config --global user.email "$email"
fi
if [ ! -d .git ]; then
  git init -q
  git symbolic-ref HEAD refs/heads/main
  ok "initialised git repo on branch main"
fi
git add -A
if git diff --cached --quiet; then
  ok "nothing new to commit"
else
  if [ -z "$MSG" ]; then
    if git rev-parse --verify -q HEAD >/dev/null; then MSG="Update $KIND"
    else MSG="Add $KIND with checker and CI"; fi
  fi
  git commit -q -m "$MSG"
  ok "committed: $MSG"
fi
git branch -M main

# ------------------------------------------------------------------ 5. GitHub repo
step "5/6  Making sure github.com/$GH_USER/$REPO exists"
gh_ready=0
if [ "$USE_GH" -eq 1 ] && command -v gh >/dev/null && gh auth status >/dev/null 2>&1; then
  if [ "$(gh api user --jq .login 2>/dev/null)" = "$GH_USER" ]; then gh_ready=1
  else warn "gh is logged in as a different user, so it won't be used"; fi
fi

if [ "$gh_ready" -eq 1 ]; then
  if gh repo view "$GH_USER/$REPO" >/dev/null 2>&1; then
    ok "repo already exists"
  else
    gh repo create "$GH_USER/$REPO" --public --description "$DESC" >/dev/null
    ok "created public repo $GH_USER/$REPO"
  fi
  topic_args=(); for t in "${TOPICS[@]}"; do topic_args+=(--add-topic "$t"); done
  gh repo edit "$GH_USER/$REPO" --description "$DESC" "${topic_args[@]}" >/dev/null && ok "description and topics set"
  [ "$USE_SSH" -eq 0 ] && gh auth setup-git >/dev/null 2>&1 || true
elif GIT_TERMINAL_PROMPT=0 git -c credential.helper= ls-remote "https://github.com/$GH_USER/$REPO.git" >/dev/null 2>&1; then
  ok "repo already exists"
else
  cat <<EOF
    The GitHub CLI isn't set up, so create the repo by hand (takes 30 seconds):

      1. Open  https://github.com/new
      2. Repository name:  $REPO
      3. Public. Do NOT tick "Add a README", .gitignore or license (it must be empty).
      4. Click "Create repository".

    Description you can paste:
      $DESC
    Topics you can add (gear icon next to "About"):
      ${TOPICS[*]}
EOF
  read -r -p "    Press Enter once the empty repo exists... " _
fi

# ------------------------------------------------------------------ 6. push
step "6/6  Pushing"
if [ "$USE_SSH" -eq 1 ]; then URL="git@github.com:$GH_USER/$REPO.git"
else URL="https://github.com/$GH_USER/$REPO.git"; fi

if git remote get-url origin >/dev/null 2>&1; then git remote set-url origin "$URL"
else git remote add origin "$URL"; fi
ok "origin = $URL"

if [ "$USE_SSH" -eq 0 ] && [ "$gh_ready" -eq 0 ]; then
  cat <<EOF
    If git asks for a username and password:
      Username: $GH_USER
      Password: a Personal Access Token, NOT your GitHub password.
                Create one at https://github.com/settings/tokens
                (classic token: tick "repo" AND "workflow". The workflow scope is
                 needed because the repo contains a .github/workflows/ file)
EOF
fi

if git push -u origin main; then
  cat <<EOF

${G}${B}Done.${N}
  Repo:        https://github.com/$GH_USER/$REPO
  CI runs:     https://github.com/$GH_USER/$REPO/actions
  The badge in the README turns green after the first CI run (about a minute).

  Next: on your profile page, click "Customize your pins" and pin $REPO.
EOF
else
  cat <<EOF >&2

${R}Push failed.${N} Common causes:
  * "Authentication failed"  -> use a Personal Access Token as the password, not your account password.
  * "refusing to allow a Personal Access Token to create or update workflow"
                             -> the token needs the "workflow" scope. Make a new token with repo + workflow.
  * "rejected ... fetch first" -> GitHub has commits you don't have (a README made on the site, or a push
                             from another computer). Run:
                             git pull --rebase origin main && git push -u origin main
  * "Repository not found"   -> create the repo first, and check the username/repo name spelling.
Then simply run this script again; it is safe to re-run.
EOF
  exit 1
fi
