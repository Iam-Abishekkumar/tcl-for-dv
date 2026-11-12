# Exercise 8: loops
# Task: loop over tests, count results, find the first failure
# Expected output:
#   running fifo_test
#   running uart_test
#   running spi_test
#   running i2c_test
#   pass=3 fail=1
#   first failure: spi_test
#   squares: 1 4 9 16 25
set tests {fifo_test uart_test spi_test i2c_test}
set results {pass pass fail pass}

foreach t $tests {
    puts "running $t"
}

set pass 0
set fail 0
for {set i 0} {$i < [llength $results]} {incr i} {
    if {[lindex $results $i] eq "pass"} {
        incr pass
    } else {
        incr fail
    }
}
puts "pass=$pass fail=$fail"

foreach t $tests r $results {
    if {$r eq "fail"} {
        puts "first failure: $t"
        break
    }
}

set squares {}
for {set i 1} {$i <= 5} {incr i} {
    lappend squares [expr {$i * $i}]
}
puts "squares: $squares"
