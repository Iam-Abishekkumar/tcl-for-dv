# Exercise 10: arrays
# Task: build a test result table and summarize it
# Expected output:
#   total: 4
#   fifo_test: PASS
#   i2c_test: PASS
#   spi_test: FAIL
#   uart_test: PASS
#   pass=3 fail=1
#   dma_test: not run
#   after delete: 3
array set result {fifo_test PASS uart_test PASS spi_test FAIL i2c_test PASS}
puts "total: [array size result]"

set pass 0
set fail 0
foreach name [lsort [array names result]] {
    puts "$name: $result($name)"
    if {$result($name) eq "PASS"} {
        incr pass
    } else {
        incr fail
    }
}
puts "pass=$pass fail=$fail"

if {[info exists result(dma_test)]} {
    puts "dma_test: $result(dma_test)"
} else {
    puts "dma_test: not run"
}

unset result(spi_test)
puts "after delete: [array size result]"
