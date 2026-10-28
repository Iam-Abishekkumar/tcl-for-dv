# Tcl for Design Verification

[![check](https://github.com/Iam-Abishekkumar/tcl-for-dv/actions/workflows/check.yml/badge.svg)](https://github.com/Iam-Abishekkumar/tcl-for-dv/actions/workflows/check.yml)

Tcl exercises I wrote while learning Tcl for design verification. Tcl is the command language inside most EDA tools
(Questa/ModelSim, VCS UCLI, Xcelium, Design Compiler, PrimeTime, Genus, Vivado), so these exercises use DV data:
test lists, seeds, register values, UVM log lines and regression summaries.
**Every file is run with tclsh on each push and compared with its saved real output.**

**Published: 0 of 21 exercises**

## Topics

| # | Topic | Exercises | Status |
|---|---|---|---|
| 01 | What Tcl is: the command model | 0 / 1 | ⬜ |
| 02 | Variables: set and $ | 0 / 1 | ⬜ |
| 03 | Basic syntax: quotes, braces, brackets, backslash | 0 / 4 | ⬜ |
| 04 | Arithmetic with expr | 0 / 1 | ⬜ |
| 05 | Logical and bitwise operators | 0 / 1 | ⬜ |
| 06 | Conditionals: if, switch, ternary | 0 / 1 | ⬜ |
| 07 | Lists | 0 / 2 | ⬜ |
| 08 | Loops: for, while, foreach | 0 / 2 | ⬜ |
| 09 | String commands | 0 / 3 | ⬜ |
| 10 | Arrays | 0 / 3 | ⬜ |
| 11 | Dictionaries | 0 / 1 | ⬜ |
| 12 | File handling | 0 / 1 | ⬜ |

## How each file is checked

```text
 exNN_name.tcl   ──►  check.sh runs: tclsh exNN_name.tcl  ──►  compares with exNN_name.out  ──►  PASS / FAIL
```

Each file starts with its task and its expected output as comments. GitHub Actions installs Tcl and runs `./check.sh` on every push.

```bash
sudo apt install tcl
git clone https://github.com/Iam-Abishekkumar/tcl-for-dv.git
cd tcl-for-dv
./check.sh
```

## About these exercises

These are my exercises from a Tcl course, written while learning. Before publishing, I reviewed them and cleaned small things
(output text matching the expected output, `default` in `switch`, indentation); the mistakes I made along the way are in my notes.
Next topics: procedures, namespaces, `exec`, `regexp`, `catch`, `glob`, then three DV projects (log scanner, regression summarizer, test-list processor).

## Layout

```text
NN_section/NN_topic/
├── README.md          what the topic is and the key rules
├── exNN_name.tcl      my exercise (task and expected output at the top)
└── exNN_name.out      its real output
check.sh               runs every file and compares with its .out
push                   publishes my next exercises: ./push 2
```

Requirements: Tcl 8.6 (`tclsh`).
