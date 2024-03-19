# Randomness Verification

The [NIST Statistical Test Suite sts-2.1.2](../../../main/NIST/sts-2.1.2) was included to test the randomness of the outputs of both modules. 
Inside the [sts-2.1.2](../../../main/NIST/sts-2.1.2) folder:
1. Copy the `test.txt` and `test02.txt obtained from the [c-implementation](../../../main/c-implementation).
2. Clean and rebuild, by running
```bash
$ make clean
$ make
```
3. A new `assess` executable will be created. Execute it by calling
```bash
$ ./assess 32
```
   where 32 is the bitstreams length (32 bits).

By following the steps below, the suite will generate the output result.

![Run example](https://raw.githubusercontent.com/pontazaricardo/pseudo-random-number-generator_verilog/main/gifs/NIST_gif/NIST_suite_result_04.gif)

The results of the statistical tests are output in the [finalAnalysisReport.txt](experiments/AlgorithmTesting/finalAnalysisReport.txt) file.

# Interpretation of the Results

The [finalAnalysisReport.txt](experiments/AlgorithmTesting/finalAnalysisReport.txt) file contains a table with the tests names and the proportion of how many bitstreams passed each test.

| C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 |C10 | P-VALUE | PROPORTION | STATISTICAL TEST |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 185 | 153 | 172 | 0 | 146 | 0 | 0 | 215 | 0 | 129 | 0.000000 | 987/1000 | `Frequency` |
| 119 | 205 | 90 | 169 | 0 | 141 | 90 | 70 | 66 | 50 | 0.000000 | 997/1000 | `BlockFrequency` |
| 117 | 92 | 87 | 103 | 145 | 109 | 0 | 141 | 153 | 53 | 0.000000 | 987/1000 | `CumulativeSums` |
| 119 | 147 | 26 | 140 | 128 | 143 | 0 | 164 | 82 | 51 | 0.000000 | 986/1000 | `CumulativeSums` |
|  82 | 180 | 77 | 40 | 155 | 69 | 38 | 128 | 104 | 127 | 0.000000 | 987/1000 | `Runs` |

A detailed description of all four statistical tests is shown [here](https://csrc.nist.gov/Projects/random-bit-generation/Documentation-and-Software/Guide-to-the-Statistical-Tests). In the report, you can find the following comment
```
The minimum pass rate for each statistical test with the exception of the
random excursion (variant) test is approximately = 980 for a
sample size = 1000 binary sequences.
```
So, in order for a test to be considered as `passed`, a **minimum proportion of 980/10000 must be returned**.
