# 05 · Logical and bitwise operators

Logical `&& || !` give 1 or 0. Bitwise `& | ^ ~ << >>` work on bits; `0x` starts a hex number.
Read bit n: `($reg >> n) & 1`; set it: `$reg | (1 << n)`; clear it: `$reg & ~(1 << n)`.

## Exercises

<!-- exercises -->
| Exercise | What it does | Output |
|---|---|---|
| [`ex01_register_bits.tcl`](ex01_register_bits.tcl) | decode a register value with masks and shifts | [ex01_register_bits.out](ex01_register_bits.out) |
<!-- /exercises -->
