# 03 · Basic syntax: quotes, braces, brackets, backslash

| Syntax | Does |
|---|---|
| `"…"` | groups words and substitutes `$var`, `[cmd]`, `\n` |
| `{…}` | groups words and substitutes **nothing** |
| `[cmd]` | runs the command first and puts its result in its place |
| `\` | escapes: `\$`, `\[`, `\t` |

Single quotes are not special in Tcl.

## Exercises

<!-- exercises -->
| Exercise | What it does | Output |
|---|---|---|
| [`ex01_quotes_vs_braces.tcl`](ex01_quotes_vs_braces.tcl) | show the difference between "" and {} grouping | [ex01_quotes_vs_braces.out](ex01_quotes_vs_braces.out) |
| [`ex02_command_substitution.tcl`](ex02_command_substitution.tcl) | use [ ] to run a command and use its result | [ex02_command_substitution.out](ex02_command_substitution.out) |
<!-- /exercises -->
