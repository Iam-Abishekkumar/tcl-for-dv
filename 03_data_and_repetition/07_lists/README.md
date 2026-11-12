# 07 · Lists

`llength`, `lindex $l 0` (index 0 is the first, `end` the last), `lrange`, `lsort`, `split`, `join`.
Commands that **change** a list take its name (`lappend l x`); the others take the value and return a new list.
`{*}$list` expands a list into separate arguments.

## Exercises

<!-- exercises -->
| Exercise | What it does | Output |
|---|---|---|
| [`ex01_test_list.tcl`](ex01_test_list.tcl) | build and edit a regression test list | [ex01_test_list.out](ex01_test_list.out) |
| [`ex02_expand_append.tcl`](ex02_expand_append.tcl) | append the elements of one list to another, versus appending the list as one element | [ex02_expand_append.out](ex02_expand_append.out) |
<!-- /exercises -->
