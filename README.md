# Advent of Code 2024

Solutions to [Advent of Code 2024 edition](https://adventofcode.com/2024) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┬────────┐
│ day │ part │       time │     memory │ allocs │
├─────┼──────┼────────────┼────────────┼────────┤
│   1 │    0 │ 479.105 μs │ 590.45 KiB │   6055 │
│   1 │    1 │  18.691 μs │  40.50 KiB │     19 │
│   1 │    2 │ 127.411 μs │   48 bytes │      2 │
├─────┼──────┼────────────┼────────────┼────────┤
│   2 │    0 │ 850.764 μs │ 877.96 KiB │  10546 │
│   2 │    1 │  52.777 μs │ 101.36 KiB │   2000 │
│   2 │    2 │ 781.700 μs │   1.65 MiB │  36742 │
├─────┼──────┼────────────┼────────────┼────────┤
│   3 │    0 │  14.665 μs │  40.43 KiB │     30 │
│   3 │    1 │ 374.366 μs │ 425.50 KiB │   6624 │
│   3 │    2 │   1.207 ms │ 200.77 KiB │   2998 │
├─────┼──────┼────────────┼────────────┼────────┤
│   4 │    0 │ 143.122 μs │ 294.48 KiB │    198 │
│   4 │    1 │   5.537 ms │   5.57 MiB │ 131358 │
│   4 │    2 │   1.076 ms │   1.04 MiB │  24247 │
├─────┼──────┼────────────┼────────────┼────────┤
│   5 │    0 │ 853.046 μs │   1.24 MiB │  13858 │
│   5 │    1 │   1.009 ms │ 148.48 KiB │    816 │
│   5 │    2 │  11.755 ms │  21.72 MiB │ 171754 │
├─────┼──────┼────────────┼────────────┼────────┤
│   6 │    0 │ 158.928 μs │ 246.32 KiB │   2278 │
│   6 │    1 │ 460.036 μs │ 568.95 KiB │  13447 │
│   6 │    2 │  31.377 ms │  64.66 MiB │ 444927 │
├─────┼──────┼────────────┼────────────┼────────┤
│   7 │    0 │   1.026 ms │   1.09 MiB │   9912 │
│   7 │    1 │ 946.439 μs │   1.52 MiB │  36171 │
│   7 │    2 │   6.692 ms │   8.24 MiB │ 243767 │
├─────┼──────┼────────────┼────────────┼────────┤
│   8 │    0 │  27.366 μs │  33.60 KiB │    342 │
│   8 │    1 │  12.662 μs │  23.09 KiB │     15 │
│   8 │    2 │  71.017 μs │  91.19 KiB │     20 │
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
  CPU: 4 × Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
  WORD_SIZE: 64
  LLVM: libLLVM-16.0.6 (ORCJIT, broadwell)
Threads: 1 default, 0 interactive, 1 GC (on 4 virtual cores)

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
