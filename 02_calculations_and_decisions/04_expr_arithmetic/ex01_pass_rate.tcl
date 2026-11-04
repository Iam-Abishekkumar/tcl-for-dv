# Exercise 4: expr arithmetic
# Task: compute test totals and pass rate
# Expected output:
#   total=10
#   failed=2
#   pass rate=80.0%
#   avg per test=2.5
set passed 8
set errors 2
set total [expr {$passed + $errors}]
puts "total=$total"
set failed [expr {$total - $passed}]
puts "failed=$failed"
set pass_rate [expr {$passed * 100.0 / $total}]
puts "pass rate=$pass_rate%"
set runtime 25.0
set avg_per_test [expr {$runtime / $total}]
puts "avg per test=$avg_per_test"
