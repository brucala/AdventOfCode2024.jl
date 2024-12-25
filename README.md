# Advent of Code 2024

Solutions to [Advent of Code 2024 edition](https://adventofcode.com/2024) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┬────────┐
│ day │ part │       time │     memory │ allocs │
├─────┼──────┼────────────┼────────────┼────────┤
│   1 │    0 │ 219.409 μs │ 590.45 KiB │   6055 │
│   1 │    1 │  16.536 μs │  40.50 KiB │     19 │
│   1 │    2 │  54.734 μs │   48 bytes │      2 │
├─────┼──────┼────────────┼────────────┼────────┤
│   2 │    0 │ 402.937 μs │ 877.96 KiB │  10546 │
│   2 │    1 │  24.591 μs │ 101.36 KiB │   2000 │
│   2 │    2 │ 378.059 μs │   1.65 MiB │  36742 │
├─────┼──────┼────────────┼────────────┼────────┤
│   3 │    0 │   4.753 μs │  40.43 KiB │     30 │
│   3 │    1 │ 205.101 μs │ 425.50 KiB │   6624 │
│   3 │    2 │ 804.033 μs │ 200.77 KiB │   2998 │
├─────┼──────┼────────────┼────────────┼────────┤
│   4 │    0 │  70.221 μs │ 294.48 KiB │    198 │
│   4 │    1 │   2.826 ms │   5.57 MiB │ 131358 │
│   4 │    2 │ 503.444 μs │   1.04 MiB │  24247 │
├─────┼──────┼────────────┼────────────┼────────┤
│   5 │    0 │ 449.445 μs │   1.24 MiB │  13858 │
│   5 │    1 │ 631.682 μs │ 148.48 KiB │    816 │
│   5 │    2 │   6.954 ms │  21.72 MiB │ 171754 │
├─────┼──────┼────────────┼────────────┼────────┤
│   6 │    0 │  89.730 μs │ 246.32 KiB │   2278 │
│   6 │    1 │ 310.891 μs │ 568.95 KiB │  13447 │
│   6 │    2 │  19.450 ms │  64.66 MiB │ 444927 │
├─────┼──────┼────────────┼────────────┼────────┤
│   7 │    0 │ 520.712 μs │   1.09 MiB │   9912 │
│   7 │    1 │ 446.033 μs │   1.52 MiB │  36171 │
│   7 │    2 │   3.521 ms │   8.24 MiB │ 243767 │
├─────┼──────┼────────────┼────────────┼────────┤
│   8 │    0 │  11.735 μs │  33.60 KiB │    342 │
│   8 │    1 │   7.175 μs │  23.09 KiB │     15 │
│   8 │    2 │  55.858 μs │  91.19 KiB │     20 │
├─────┼──────┼────────────┼────────────┼────────┤
│   9 │    0 │  90.084 μs │ 275.18 KiB │     36 │
│   9 │    1 │ 163.463 μs │   1.10 MiB │  13765 │
│   9 │    2 │  31.046 ms │   1.05 MiB │  19585 │
├─────┼──────┼────────────┼────────────┼────────┤
│  10 │    0 │  17.568 μs │  82.08 KiB │     97 │
│  10 │    1 │ 181.292 μs │ 951.95 KiB │   6692 │
│  10 │    2 │ 186.285 μs │ 951.95 KiB │   6692 │
├─────┼──────┼────────────┼────────────┼────────┤
│  11 │    0 │   2.869 μs │   1.92 KiB │     34 │
│  11 │    1 │ 342.556 μs │ 539.31 KiB │  12811 │
│  11 │    2 │  21.668 ms │  27.01 MiB │ 601445 │
├─────┼──────┼────────────┼────────────┼────────┤
│  12 │    0 │  71.797 μs │ 294.48 KiB │    198 │
│  12 │    1 │   3.894 ms │   6.94 MiB │  58835 │
│  12 │    2 │  14.135 ms │  21.74 MiB │ 278179 │
├─────┼──────┼────────────┼────────────┼────────┤
│  13 │    0 │ 243.340 μs │ 673.50 KiB │   6764 │
│  13 │    1 │   8.555 μs │    0 bytes │      0 │
│  13 │    2 │  23.685 μs │    0 bytes │      0 │
├─────┼──────┼────────────┼────────────┼────────┤
│  14 │    0 │ 915.102 μs │ 983.73 KiB │  15551 │
│  14 │    1 │   2.387 μs │   64 bytes │      1 │
│  14 │    2 │  68.392 ms │ 476.12 KiB │   7495 │
├─────┼──────┼────────────┼────────────┼────────┤
│  15 │    0 │  39.896 μs │ 111.22 KiB │    108 │
│  15 │    1 │   9.108 ms │   5.47 MiB │ 201680 │
│  15 │    2 │  16.429 ms │   9.81 MiB │ 292880 │
├─────┼──────┼────────────┼────────────┼────────┤
│  16 │    0 │  75.164 μs │ 296.17 KiB │    199 │
│  16 │    1 │   6.098 ms │   2.67 MiB │  17981 │
│  16 │    2 │  32.138 ms │ 241.66 MiB │ 129499 │
├─────┼──────┼────────────┼────────────┼────────┤
│  17 │    0 │   3.822 μs │   4.89 KiB │     60 │
│  17 │    1 │  10.962 μs │   2.73 KiB │    120 │
│  17 │    2 │   2.740 ms │ 491.95 KiB │  25989 │
├─────┼──────┼────────────┼────────────┼────────┤
│  18 │    0 │   1.268 ms │   1.93 MiB │  24202 │
│  18 │    1 │   1.849 ms │ 444.27 KiB │     64 │
│  18 │    2 │   2.973 ms │   2.92 MiB │    403 │
└─────┴──────┴────────────┴────────────┴────────┘

```

> **Part 0** refers to the **parsing of the input data**.

Results above run under the following `versioninfo()`:
```
Julia Version 1.11.2
Commit 5e9a32e7af2 (2024-12-01 20:02 UTC)
Build Info:
  Official https://julialang.org/ release
Platform Info:
  OS: Linux (x86_64-linux-gnu)
  CPU: 8 × 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
  WORD_SIZE: 64
  LLVM: libLLVM-16.0.6 (ORCJIT, tigerlake)
Threads: 1 default, 0 interactive, 1 GC (on 8 virtual cores)
Environment:
  JULIA_PROJECT = @.

```

## Other CLI tools

To generate (src and test) templates for a given day:
```
$ julia cli/generate_day.jl -h
usage: generate_day.jl [-h] nday

positional arguments:
  nday        day number for files to be generated

optional arguments:
  -h, --help  show this help message and exit
```

To download the input data of a given day:
```
$ julia cli/get_input.jl -h
usage: get_input.jl [-d DAY] [-h]

optional arguments:
  -d, --day DAY  day number for the input to be downloaded. If not
                 given take today's input (type: Int64)
  -h, --help     show this help message and exit
```
