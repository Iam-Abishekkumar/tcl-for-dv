# 02 · Variables: set and $

`set name value` creates or changes a variable (no `$`); `$name` reads it. There are no types.
A name continues through letters, digits and `_`, so use `${name}_test`. Reading a variable that was never set is an error.

## Exercises

<!-- exercises -->
| Exercise | What it does | Output |
|---|---|---|
| [`ex01_set_and_print.tcl`](ex01_set_and_print.tcl) | create variables, print them in one line, change one, print again, then read a variable that was never created | [ex01_set_and_print.out](ex01_set_and_print.out) |
<!-- /exercises -->
