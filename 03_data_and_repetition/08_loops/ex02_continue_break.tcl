# Exercise 8b: continue and break
# Task: skip spi_test, stop completely at i2c_test
# Expected output:
#   running fifo_test
#   running uart_test
set tests {fifo_test uart_test spi_test i2c_test dma_test}
foreach t $tests {
    if {$t eq "spi_test"} { continue }
    if {$t eq "i2c_test"} { break }
    puts "running $t"
}
