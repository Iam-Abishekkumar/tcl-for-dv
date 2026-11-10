# Exercise 6: conditionals
# Task: classify a test result using if/elseif/else, switch, and ternary
# Expected output:
#   RESULT: FAIL (2 errors)
#   action: debug the failure
#   seed type: odd
set errors 2
set warnings 1
set status "FAIL"
if {$errors > 0} {
    puts "RESULT: $status ($errors errors)"
} elseif {$warnings > 0} {
    puts "RESULT: PASS with $warnings warnings"
} else {
    puts "RESULT: PASS clean"
}

switch $status {
    FAIL    { puts "action: debug the failure" }
    PASS    { puts "action: none" }
    default { puts "action: check the log" }
}

set seed 7
puts "seed type: [expr {$seed % 2 != 0 ? "odd" : "even"}]"
