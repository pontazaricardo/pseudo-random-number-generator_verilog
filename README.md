# pseudo-random-number-generator_verilog
This repository shows how to create a 32-bits pseudo-random number generator using Verilog, and test the type of randomness using the NIST Statistical Test Suite.

## Files description

The [main](main/) directory in this repository consists of three sections:
1. **Verilog**: This section consist of
    - Two verilog modules: [Generator.v](main/verilog/Generator.v) and [XORShifter.v](main/verilog/XORShifter.v), which implement the [Middle-square algorithm](https://en.wikipedia.org/wiki/Middle-square_method) and the [XORShifter method](https://en.wikipedia.org/wiki/Xorshift), respectively, to generate pseudo-random numbers.
    - Two testbech modules [generator_testbench.v](main/verilog/generator_testbench.v) and [xorshifter_testbench.v](main/verilog/xorshifter_testbench.v)
2. **C-Implementation**: This section consist of the [c-implementation](main/c-implementation) subfolder, which contains a C application to replicate the generated random values produced by the `Generator.v` and `XORShifter.v`. This program produces 1,000 bitstreams of 32-bits each, and outputs them in two files: [test.txt](main/c-implementation/test.txt) and [test02.txt](main/c-implementation/test02.txt). The `test.txt` file contains the simulated outputs of `Generator.v`, while `test02.txt` contains the outputs of `XORShifter.v`.
3. **NIST Statistical Test Suite**: This section consist of the [sts-2.1.2](main/NIST/sts-2.1.2) Statistical Test Suite subfolder, which contains a C application to test the randomness of the outputs of the verilog modules. A description of the statistical tests performed by this software is shown [here](https://csrc.nist.gov/Projects/random-bit-generation/Documentation-and-Software/Guide-to-the-Statistical-Tests). An stand-alone repository can be found [here](https://csrc.nist.gov/CSRC/media/Projects/Random-Bit-Generation/documents/sts-2_1_2.zip) and the instruction manual is shown [here](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-22r1a.pdf).

## Verilog Modules

Both the `Generator.v` and the `XORShifter.v` are tested using the `generator_testbench.v` and the `xorshifter_testbench.v` testbench, respectively. Both modules have input and output:
```verilog
input [31:0] seed;
output [31:0] generatedRandom;
```
meaning that they produce 32-bits random numbers. The output is fed back as input to keep generating random numbers. Example of this is shown in the `generator_testbench.v` testbench:
```verilog
reg [31:0] recurrentSeed;
wire [31:0] generatedRandom;
    
Generator generator (recurrentSeed, generatedRandom);

initial begin
    
    #0 recurrentSeed = 32'd20240301;
    forever
    #10 recurrentSeed = generatedRandom;    // <=== Feedback loop
end
```
where the ouptput is fed back to the `Generator.v` as a new input every 10 nanoseconds.

### Notes

There are two important notes for the verilog modules:
1. The static initial seed 20240301 was used in both testbenches. This static initial seed is also used in the [c-implementation](main/c-implementation) for replication and simulation purposes. In case this seed is modified in the testbenches, it must be modified in the [c-implementation](main/c-implementation) as well to generate the same values.
2. The `XORShifter.v` has the following structure
```verilog
wire [31:0] step01 = seed ^ seed >> 7;
wire [31:0] step02 = step01 ^ step01 << 9;
assign generatedRandom  = step02 ^ step02 >>13;
```
where there are shifts of 7, 9 and 13 bits. These numbers were selected as it **shakes** the bits in the wire, while keeping most of the bits in the middle. Different values can generate different quality of random numbers.

## Verilog Testbench Waveform

When running the testbenches `generator_testbench.v` and `xorshifter_testbench.v`, both generate their respective waveform. By default, the inputs and outputs are displayed in hexadecimal. This can be changed to Decimal by:
1. Adding the variables to the simulation.
2. Change the Radix to *unsigned integer*.
3. Relaunch the simulation.

This will yield in the `generator_testbench.v` waveform:

![Run example](https://raw.githubusercontent.com/pontazaricardo/pseudo-random-number-generator_verilog/main/gifs/Verilog_gif/generatorTestbench.gif)

and in the `xorshifter_testbench.v` waveform:

![Run example](https://raw.githubusercontent.com/pontazaricardo/pseudo-random-number-generator_verilog/main/gifs/Verilog_gif/xorshifterTestbench.gif)

## Verilog Output Simulation (C implementation)

A [c-implementation](main/c-implementation) was added as well to simulate 1,000 bitstreams that will be output by both the `Generator.v` and the `XORShifter.v` modules.
To run it:
1. Go to the [c-implementation](main/c-implementation) folder
2. Run
```bash
$ make clean
$ make
$ ./generator
```
This will output two files: `test.txt` and `test02.txt`, with the outputs of `Generator.v` and the `XORShifter.v`, respectively.

![Run example](https://raw.githubusercontent.com/pontazaricardo/pseudo-random-number-generator_verilog/main/gifs/c-implementation_gif/c-implementation.gif)

If you want to generate more than 1,000 bitstreams, in the `generator.c` file, modify the limit in the cycle:

```c
int main() {
    ...
    for(int i=0;i<1000;i++){ // <=== Change here
        ...
    }
    ...
}
```
## Randomness Verification

The [NIST Statistical Test Suite sts-2.1.2](main/NIST/sts-2.1.2) was included to test the randomness of the outputs of both modules. 
Inside the [sts-2.1.2](main/NIST/sts-2.1.2) folder:
1. Copy the `test.txt` and `test02.txt obtained from the [c-implementation](main/c-implementation).
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

The results of the statistical tests are output in the [finalAnalysisReport.txt](main/NIST/sts-2.1.2/experiments/AlgorithmTesting/finalAnalysisReport.txt) file.

### Interpretation of the Results


| C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 |C10 | P-VALUE | PROPORTION | STATISTICAL TEST |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 185 | 153 | 172 | 0 | 146 | 0 | 0 | 215 | 0 | 129 | 0.000000 | 987/1000 | `Frequency` |
| 119 | 205 | 90 | 169 | 0 | 141 | 90 | 70 | 66 | 50 | 0.000000 | 997/1000 | `BlockFrequency` |
| 117 | 92 | 87 | 103 | 145 | 109 | 0 | 141 | 153 | 53 | 0.000000 | 987/1000 | `CumulativeSums` |
| 119 | 147 | 26 | 140 | 128 | 143 | 0 | 164 | 82 | 51 | 0.000000 | 986/1000 | `CumulativeSums` |
|  82 | 180 | 77 | 40 | 155 | 69 | 38 | 128 | 104 | 127 | 0.000000 | 987/1000 | `Runs` |
