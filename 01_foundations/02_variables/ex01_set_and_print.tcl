# Exercise 2: Variables
# Task: create variables, print them in one line, change one, print again, then read a variable that was never created
# Expected output:
#   fifo_test seed=42 status=PASS
#   fifo_test seed=42 status=FAIL
#   (then the error: can't read "abc": no such variable)
set test_name "fifo_test"
set seed 42
set status PASS
puts "$test_name seed=$seed status=$status"
set status FAIL
puts "$test_name seed=$seed status=$status"
# on purpose: abc was never created, so this line stops the script with an error
puts $abc
