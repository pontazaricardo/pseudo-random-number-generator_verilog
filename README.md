# pseudo-random-number-generator_verilog
This repository shows how to create a 32-bits pseudo-random number generator using Verilog, and test the type of randomness using the NIST Statistical Test Suite

The ([main](main/){:target="_blank"}) directory in this repository consists of three sections:
1. **Verilog**: The two verilog modules ([Generator.v](main/verilog/Generator.v)) and ([XORShifter.v](main/verilog/XORShifter.v)), which implement the ([Middle-square algorithm](https://en.wikipedia.org/wiki/Middle-square_method)) and the ([XORShifter method](https://en.wikipedia.org/wiki/Xorshift)) to generate pseudo-random numbers.
