# Exercise 9b: strings on a signal name
# Task: inspect a hierarchical signal name
# Expected output:
#   length: 18
#   last char: n
#   module: fifo
#   upper: TOP.DUT.FIFO.WR_EN
set sig "TOP.dut.fifo.wr_en"
puts "length: [string length $sig]"
puts "last char: [string index $sig end]"
set parts [split $sig "."]
puts "module: [lindex $parts 2]"
puts "upper: [string toupper $sig]"
