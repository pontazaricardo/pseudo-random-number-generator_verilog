# pseudo-random-number-generator_verilog
This repository shows how to create a 32-bits pseudo-random number generator using Verilog, and test the type of randomness using the NIST Statistical Test Suite

The [main](main/) directory in this repository consists of three sections:
1. **Verilog**: This section consist of
  - Two verilog modules ([Generator.v](main/verilog/Generator.v)) and ([XORShifter.v](main/verilog/XORShifter.v)), which implement the ([Middle-square algorithm](https://en.wikipedia.org/wiki/Middle-square_method)) and the ([XORShifter method](https://en.wikipedia.org/wiki/Xorshift)) to generate pseudo-random numbers.
  - Two testbech modules ([generator_testbench.v](main/verilog/generator_testbench.v)) and ([xorshifter_testbench.v](main/verilog/xorshifter_testbench.v))
