# 04 · Arithmetic with expr

Tcl does no maths by itself: `set x 10+5` stores the text `10+5`. Use `[expr {…}]`, always with braces.
If both sides of `/` are whole numbers the result is whole (`12/7` is `1`); write `12.0/7` to keep the fraction.

## Exercises

<!-- exercises -->
| Exercise | What it does | Output |
|---|---|---|
| [`ex01_pass_rate.tcl`](ex01_pass_rate.tcl) | compute test totals and pass rate | [ex01_pass_rate.out](ex01_pass_rate.out) |
<!-- /exercises -->
