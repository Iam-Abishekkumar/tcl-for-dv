# Exercise 3B: Command substitution
# Task: use [ ] to run a command and use its result
# Expected output:
#   5
#   Name uart_test has 9 characters
set word hello
set len [string length $word]
puts $len
set name "uart_test"
puts "Name $name has [string length $name] characters"
