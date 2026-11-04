# Exercise 3 revision: quotes, braces, brackets, backslash
# Task: print a small test report using all four tools
# Expected output:
#   [PASS] uart_test (9 chars)
#   log file: uart_test_seed42.log
#   Usage: run_test $test_name
set test_name "uart_test"
set seed 42
puts "\[PASS\] ${test_name} ([string length ${test_name}] chars)"
puts "log file: ${test_name}_seed$seed.log"
puts {Usage: run_test $test_name}
