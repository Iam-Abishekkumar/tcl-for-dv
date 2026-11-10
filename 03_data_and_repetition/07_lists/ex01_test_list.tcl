# Exercise 7: lists
# Task: build and edit a regression test list
# Expected output:
#   tests: fifo_test uart_test spi_test
#   count: 3
#   after append: fifo_test uart_test spi_test i2c_test
#   sorted: fifo_test i2c_test spi_test uart_test
#   second test: i2c_test
#   without first: i2c_test spi_test uart_test
#   from csv: 3 elements, last is c
set tests {fifo_test uart_test spi_test}
puts "tests: $tests"
puts "count: [llength $tests]"
lappend tests i2c_test
puts "after append: $tests"
set sorted [lsort $tests]
puts "sorted: $sorted"
puts "second test: [lindex $sorted 1]"
puts "without first: [lrange $sorted 1 end]"
set m [split "a,b,c" ","]
puts "from csv: [llength $m] elements, last is [lindex $m end]"
