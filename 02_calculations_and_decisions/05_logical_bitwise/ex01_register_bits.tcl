# Exercise 5: logical and bitwise operators
# Task: decode a register value with masks and shifts
# Expected output:
#   bit2=1
#   upper nibble=11
#   lower nibble=6
#   set bit0=183
#   clear bit1=180
#   bit7 and bit0 both set=0
set reg 0xb6
puts "bit2=[expr {($reg >> 2) & 0x01}]"
puts "upper nibble=[expr {($reg >> 4) & 0x0f}]"
puts "lower nibble=[expr {$reg & 0x0f}]"
puts "set bit0=[expr {$reg | 0x01}]"
puts "clear bit1=[expr {$reg & ~0x02}]"
puts "bit7 and bit0 both set=[expr {($reg & 128) && ($reg & 1)}]"
