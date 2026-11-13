# 08 · Loops: for, while, foreach

`for {set i 0} {$i < 5} {incr i} {…}`, `while {…} {…}`, `foreach t $list {…}`, also two at a time: `foreach {k v} …`.
The loop variable and `incr` take a **name** (no `$`). `continue` skips a round, `break` stops the loop.

## Exercises

<!-- exercises -->
| Exercise | What it does | Output |
|---|---|---|
| [`ex01_regression_loop.tcl`](ex01_regression_loop.tcl) | loop over tests, count results, find the first failure | [ex01_regression_loop.out](ex01_regression_loop.out) |
| [`ex02_continue_break.tcl`](ex02_continue_break.tcl) | skip spi_test, stop completely at i2c_test | [ex02_continue_break.out](ex02_continue_break.out) |
<!-- /exercises -->
