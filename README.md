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

![Run example](/gifs/Verilog_gif/generatorTestbench.gif?raw=true)

