# Exercise 9c: prefix in upper case
# Task: take the part of a tag before the first _ and print it in upper case
# Expected output:
#   UART
set tag "uart_test_07"
set pos [string first "_" $tag]
set part [string range $tag 0 [expr {$pos - 1}]]
puts [string toupper $part]
