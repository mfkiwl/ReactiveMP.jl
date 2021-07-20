# Benchmark result (via Travis)


# Judge result
# Benchmark Report for */home/travis/build/biaslab/ReactiveMP.jl/benchmark/../*

## Job Properties
* Time of benchmarks:
    - Target: 19 May 2021 - 10:39
    - Baseline: 19 May 2021 - 10:41
* Package commits:
    - Target: c7e60f
    - Baseline: c7e60f
* Julia commits:
    - Target: 6aaede
    - Baseline: 6aaede
* Julia command flags:
    - Target: `-O3`
    - Baseline: `-O3`
* Environment variables:
    - Target: None
    - Baseline: None

## Results
A ratio greater than `1.0` denotes a possible regression (marked with :x:), while a ratio less
than `1.0` denotes a possible improvement (marked with :white_check_mark:). Only significant results - results
that indicate possible regressions or improvements - are shown below (thus, an empty table means that all
benchmark results remained invariant between builds).

| ID                                      | time ratio | memory ratio |
|-----------------------------------------|------------|--------------|

## Benchmark Group List
Here's a list of all the benchmark groups executed by this job:

- `["models", "hgf1"]`
- `["models", "hmm1"]`
- `["models", "lgssm1"]`
- `["models", "lgssm2"]`

## Julia versioninfo

### Target
```
Julia Version 1.6.1
Commit 6aaedecc44 (2021-04-23 05:59 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
      Ubuntu 16.04.6 LTS
  uname: Linux 4.15.0-1028-gcp #29~16.04.1-Ubuntu SMP Tue Feb 12 16:31:10 UTC 2019 x86_64 x86_64
  CPU: Intel(R) Xeon(R) CPU: 
              speed         user         nice          sys         idle          irq
       #1  2800 MHz       2966 s          0 s        111 s        697 s          0 s
       #2  2800 MHz       1033 s          0 s        124 s       2636 s          0 s
       
  Memory: 7.790031433105469 GB (5801.4453125 MB free)
  Uptime: 381.0 sec
  Load Avg:  1.01  0.89  0.45
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-11.0.1 (ORCJIT, cascadelake)
```

### Baseline
```
Julia Version 1.6.1
Commit 6aaedecc44 (2021-04-23 05:59 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
      Ubuntu 16.04.6 LTS
  uname: Linux 4.15.0-1028-gcp #29~16.04.1-Ubuntu SMP Tue Feb 12 16:31:10 UTC 2019 x86_64 x86_64
  CPU: Intel(R) Xeon(R) CPU: 
              speed         user         nice          sys         idle          irq
       #1  2800 MHz       4077 s          0 s        116 s       1186 s          0 s
       #2  2800 MHz       1523 s          0 s        132 s       3743 s          0 s
       
  Memory: 7.790031433105469 GB (5786.6875 MB free)
  Uptime: 541.0 sec
  Load Avg:  1.0  0.94  0.55
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-11.0.1 (ORCJIT, cascadelake)
```

---
# Target result
# Benchmark Report for */home/travis/build/biaslab/ReactiveMP.jl/benchmark/../*

## Job Properties
* Time of benchmark: 19 May 2021 - 10:39
* Package commit: c7e60f
* Julia commit: 6aaede
* Julia command flags: `-O3`
* Environment variables: None

## Results
Below is a table of this job's results, obtained by running the benchmarks.
The values listed in the `ID` column have the structure `[parent_group, child_group, ..., key]`, and can be used to
index into the BaseBenchmarks suite to retrieve the corresponding benchmarks.
The percentages accompanying time and memory values in the below table are noise tolerances. The "true"
time/memory value for a given benchmark is expected to fall within this percentage of the reported value.
An empty cell means that the value was zero.

| ID                                      | time            | GC time   | memory          | allocations |
|-----------------------------------------|----------------:|----------:|----------------:|------------:|
| `["models", "hgf1", "creation"]`        |  38.085 μs (5%) |           |  37.95 KiB (1%) |         658 |
| `["models", "hgf1", "inference_100"]`   |  27.689 ms (5%) |           |  18.52 MiB (1%) |      304458 |
| `["models", "hgf1", "inference_1000"]`  | 310.118 ms (5%) | 33.794 ms | 184.12 MiB (1%) |     3027868 |
| `["models", "hgf1", "inference_500"]`   | 154.803 ms (5%) | 16.004 ms |  92.13 MiB (1%) |     1514865 |
| `["models", "hmm1", "creation_100"]`    |   1.812 ms (5%) |           |   1.41 MiB (1%) |       29131 |
| `["models", "hmm1", "creation_500"]`    |   8.814 ms (5%) |           |   6.96 MiB (1%) |      144337 |
| `["models", "hmm1", "inference_100"]`   |  50.540 ms (5%) |           |  34.19 MiB (1%) |      445309 |
| `["models", "hmm1", "inference_500"]`   | 337.416 ms (5%) | 68.773 ms | 170.40 MiB (1%) |     2219008 |
| `["models", "lgssm1", "creation_100"]`  |   1.178 ms (5%) |           | 951.64 KiB (1%) |       18825 |
| `["models", "lgssm1", "creation_500"]`  |   5.912 ms (5%) |           |   4.62 MiB (1%) |       93627 |
| `["models", "lgssm1", "inference_100"]` |   2.862 ms (5%) |           |   2.78 MiB (1%) |       43587 |
| `["models", "lgssm1", "inference_500"]` |  15.933 ms (5%) |           |  13.89 MiB (1%) |      217589 |
| `["models", "lgssm2", "creation_100"]`  |   1.731 ms (5%) |           |   1.37 MiB (1%) |       27174 |
| `["models", "lgssm2", "creation_500"]`  |   8.663 ms (5%) |           |   6.81 MiB (1%) |      135176 |
| `["models", "lgssm2", "inference_100"]` |   6.276 ms (5%) |           |   5.17 MiB (1%) |       76754 |
| `["models", "lgssm2", "inference_500"]` |  34.522 ms (5%) |           |  25.87 MiB (1%) |      383956 |

## Benchmark Group List
Here's a list of all the benchmark groups executed by this job:

- `["models", "hgf1"]`
- `["models", "hmm1"]`
- `["models", "lgssm1"]`
- `["models", "lgssm2"]`

## Julia versioninfo
```
Julia Version 1.6.1
Commit 6aaedecc44 (2021-04-23 05:59 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
      Ubuntu 16.04.6 LTS
  uname: Linux 4.15.0-1028-gcp #29~16.04.1-Ubuntu SMP Tue Feb 12 16:31:10 UTC 2019 x86_64 x86_64
  CPU: Intel(R) Xeon(R) CPU: 
              speed         user         nice          sys         idle          irq
       #1  2800 MHz       2966 s          0 s        111 s        697 s          0 s
       #2  2800 MHz       1033 s          0 s        124 s       2636 s          0 s
       
  Memory: 7.790031433105469 GB (5801.4453125 MB free)
  Uptime: 381.0 sec
  Load Avg:  1.01  0.89  0.45
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-11.0.1 (ORCJIT, cascadelake)
```

---
# Baseline result
# Benchmark Report for */home/travis/build/biaslab/ReactiveMP.jl/benchmark/../*

## Job Properties
* Time of benchmark: 19 May 2021 - 10:41
* Package commit: c7e60f
* Julia commit: 6aaede
* Julia command flags: `-O3`
* Environment variables: None

## Results
Below is a table of this job's results, obtained by running the benchmarks.
The values listed in the `ID` column have the structure `[parent_group, child_group, ..., key]`, and can be used to
index into the BaseBenchmarks suite to retrieve the corresponding benchmarks.
The percentages accompanying time and memory values in the below table are noise tolerances. The "true"
time/memory value for a given benchmark is expected to fall within this percentage of the reported value.
An empty cell means that the value was zero.

| ID                                      | time            | GC time   | memory          | allocations |
|-----------------------------------------|----------------:|----------:|----------------:|------------:|
| `["models", "hgf1", "creation"]`        |  37.570 μs (5%) |           |  37.95 KiB (1%) |         658 |
| `["models", "hgf1", "inference_100"]`   |  28.477 ms (5%) |           |  18.52 MiB (1%) |      304458 |
| `["models", "hgf1", "inference_1000"]`  | 320.841 ms (5%) | 32.891 ms | 184.12 MiB (1%) |     3027868 |
| `["models", "hgf1", "inference_500"]`   | 157.732 ms (5%) | 15.973 ms |  92.13 MiB (1%) |     1514865 |
| `["models", "hmm1", "creation_100"]`    |   1.812 ms (5%) |           |   1.41 MiB (1%) |       29131 |
| `["models", "hmm1", "creation_500"]`    |   8.805 ms (5%) |           |   6.96 MiB (1%) |      144337 |
| `["models", "hmm1", "inference_100"]`   |  50.489 ms (5%) |           |  34.19 MiB (1%) |      445309 |
| `["models", "hmm1", "inference_500"]`   | 342.364 ms (5%) | 68.211 ms | 170.40 MiB (1%) |     2219008 |
| `["models", "lgssm1", "creation_100"]`  |   1.195 ms (5%) |           | 951.64 KiB (1%) |       18825 |
| `["models", "lgssm1", "creation_500"]`  |   5.933 ms (5%) |           |   4.62 MiB (1%) |       93627 |
| `["models", "lgssm1", "inference_100"]` |   2.901 ms (5%) |           |   2.78 MiB (1%) |       43587 |
| `["models", "lgssm1", "inference_500"]` |  15.808 ms (5%) |           |  13.89 MiB (1%) |      217589 |
| `["models", "lgssm2", "creation_100"]`  |   1.729 ms (5%) |           |   1.37 MiB (1%) |       27174 |
| `["models", "lgssm2", "creation_500"]`  |   8.602 ms (5%) |           |   6.81 MiB (1%) |      135176 |
| `["models", "lgssm2", "inference_100"]` |   6.275 ms (5%) |           |   5.17 MiB (1%) |       76754 |
| `["models", "lgssm2", "inference_500"]` |  34.217 ms (5%) |           |  25.87 MiB (1%) |      383956 |

## Benchmark Group List
Here's a list of all the benchmark groups executed by this job:

- `["models", "hgf1"]`
- `["models", "hmm1"]`
- `["models", "lgssm1"]`
- `["models", "lgssm2"]`

## Julia versioninfo
```
Julia Version 1.6.1
Commit 6aaedecc44 (2021-04-23 05:59 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
      Ubuntu 16.04.6 LTS
  uname: Linux 4.15.0-1028-gcp #29~16.04.1-Ubuntu SMP Tue Feb 12 16:31:10 UTC 2019 x86_64 x86_64
  CPU: Intel(R) Xeon(R) CPU: 
              speed         user         nice          sys         idle          irq
       #1  2800 MHz       4077 s          0 s        116 s       1186 s          0 s
       #2  2800 MHz       1523 s          0 s        132 s       3743 s          0 s
       
  Memory: 7.790031433105469 GB (5786.6875 MB free)
  Uptime: 541.0 sec
  Load Avg:  1.0  0.94  0.55
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-11.0.1 (ORCJIT, cascadelake)
```

---
# Runtime information
| Runtime Info | |
|:--|:--|
| BLAS #threads | 2 |
| `BLAS.vendor()` | `openblas64` |
| `Sys.CPU_THREADS` | 2 |

`lscpu` output:

    Architecture:          x86_64
    CPU op-mode(s):        32-bit, 64-bit
    Byte Order:            Little Endian
    CPU(s):                2
    On-line CPU(s) list:   0,1
    Thread(s) per core:    2
    Core(s) per socket:    1
    Socket(s):             1
    NUMA node(s):          1
    Vendor ID:             GenuineIntel
    CPU family:            6
    Model:                 85
    Model name:            Intel(R) Xeon(R) CPU
    Stepping:              7
    CPU MHz:               2800.208
    BogoMIPS:              5600.41
    Hypervisor vendor:     KVM
    Virtualization type:   full
    L1d cache:             32K
    L1i cache:             32K
    L2 cache:              1024K
    L3 cache:              33792K
    NUMA node0 CPU(s):     0,1
    Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single ssbd ibrs ibpb stibp ibrs_enhanced fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx avx512f avx512dq rdseed adx smap clflushopt clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves arat avx512_vnni arch_capabilities
    

| Cpu Property       | Value                                                      |
|:------------------ |:---------------------------------------------------------- |
| Brand              | Intel(R) Xeon(R) CPU                                       |
| Vendor             | :Intel                                                     |
| Architecture       | :Skylake                                                   |
| Model              | Family: 0x06, Model: 0x55, Stepping: 0x07, Type: 0x00      |
| Cores              | 1 physical cores, 2 logical cores (on executing CPU)       |
|                    | Hyperthreading hardware capability detected                |
| Clock Frequencies  | Not supported by CPU                                       |
| Data Cache         | Level 1:3 : (32, 1024, 33792) kbytes                       |
|                    | 64 byte cache line size                                    |
| Address Size       | 48 bits virtual, 46 bits physical                          |
| SIMD               | 512 bit = 64 byte max. SIMD vector size                    |
| Time Stamp Counter | TSC is accessible via `rdtsc`                              |
|                    | TSC runs at constant rate (invariant from clock frequency) |
| Perf. Monitoring   | Performance Monitoring Counters (PMC) are not supported    |
| Hypervisor         | Yes, KVM                                                   |
