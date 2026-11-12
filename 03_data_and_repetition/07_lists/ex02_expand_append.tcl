# Exercise 7b: lappend with {*}
# Task: append the elements of one list to another, versus appending the list as one element
# Expected output:
#   5
#   dma_test
#   4
#   fifo_test uart_test spi_test {i2c_test dma_test}
set tests {fifo_test uart_test spi_test}
set extra {i2c_test dma_test}
lappend tests {*}$extra
puts [llength $tests]
puts [lindex $tests end]

set t2 {fifo_test uart_test spi_test}
lappend t2 $extra
puts [llength $t2]
puts $t2
