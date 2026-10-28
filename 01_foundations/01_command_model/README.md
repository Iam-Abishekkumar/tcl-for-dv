# 01 · What Tcl is: the command model

Every line is `command arg1 arg2 …`: words are split at spaces, a command ends at a newline or `;`, and everything is a string.
`puts ?-nonewline? ?channel? text` prints; with two words, the first is read as a **channel** (`stdout`, `stderr`, a file).
When an error looks strange, count the arguments.

## Exercises

<!-- exercises -->
| Exercise | What it does | Output |
|---|---|---|
| [`ex01_print_text.tcl`](ex01_print_text.tcl) | print text with puts, use stdout, two commands on one line | [ex01_print_text.out](ex01_print_text.out) |
<!-- /exercises -->
