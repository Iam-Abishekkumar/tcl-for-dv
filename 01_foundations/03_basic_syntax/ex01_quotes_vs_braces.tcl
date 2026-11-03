# Exercise 3A: Quotes vs braces
# Task: show the difference between "" and {} grouping
# Expected output:
#   Test: fifo_test
#   Test: $test_name
set test_name fifo_test
puts "Test: ${test_name}"
puts {Test: $test_name}
