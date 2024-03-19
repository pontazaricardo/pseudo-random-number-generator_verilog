# pseudo-random-number-generator_verilog
This repository shows how to create a 32-bits pseudo-random number generator using Verilog, and test the type of randomness using the NIST Statistical Test Suite.

## Files description

The [main](main/) directory in this repository consists of three sections:
1. **Verilog**: This section consist of
    - Two verilog modules: [Generator.v](main/verilog/Generator.v) and [XORShifter.v](main/verilog/XORShifter.v), which implement the [Middle-square algorithm](https://en.wikipedia.org/wiki/Middle-square_method) and the [XORShifter method](https://en.wikipedia.org/wiki/Xorshift), respectively, to generate pseudo-random numbers.
    - Two testbech modules [generator_testbench.v](main/verilog/generator_testbench.v) and [xorshifter_testbench.v](main/verilog/xorshifter_testbench.v)
2. **C-Implementation**: This section consist of the [c-implementation](main/c-implementation) subfolder, which contains a C application to replicate the generated random values produced by the `Generator.v` and `XORShifter.v`. This program produces 1,000 bitstreams of 32-bits each, and outputs them in two files: [test,txt](main/c-implementation/test.txt) and [test02,txt](main/c-implementation/test02.txt). The `test.txt` file contains the simulated outputs of `Generator.v`, while `test02.txt` contains the outputs of `XORShifter.v`.
3. **NIST Statistical Test Suite**: This section consist of the [sts-2.1.2](main/NIST/sts-2.1.2) Statistical Test Suite subfolder, which contains a C application to test the randomness of the outputs of the verilog modules. A description of the statistical tests performed by this software is shown [here](https://csrc.nist.gov/Projects/random-bit-generation/Documentation-and-Software/Guide-to-the-Statistical-Tests). An stand-alone repository can be found [here](https://csrc.nist.gov/CSRC/media/Projects/Random-Bit-Generation/documents/sts-2_1_2.zip) and the instruction manual is shown [here](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-22r1a.pdf).
