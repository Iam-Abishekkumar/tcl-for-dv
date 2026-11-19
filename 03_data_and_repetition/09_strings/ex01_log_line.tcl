# Exercise 9: strings
# Task: inspect a log line with string commands
# Expected output:
#   length: 39
#   severity: UVM_FATAL
#   message: fifo overflow detected
#   is fatal: 1
#   lower: uvm_fatal @ 500: fifo overflow detected
#   cleaned: UVM_FATAL_@_500:_fifo_overflow_detected
set line "UVM_FATAL @ 500: fifo overflow detected"
puts "length: [string length $line]"
puts "severity: [string range $line 0 8]"
set colon [string first ":" $line]
puts "message: [string range $line [expr {$colon + 2}] end]"
puts "is fatal: [string match "UVM_FATAL*" $line]"
puts "lower: [string tolower $line]"
puts "cleaned: [string map {" " _} $line]"
