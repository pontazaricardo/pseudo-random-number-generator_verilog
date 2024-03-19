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
1. The static initial seed 20240301 was used in both testbenches. This static initial seed is also used in the [c-implementation](../../main/c-implementation) for replication and simulation purposes. In case this seed is modified in the testbenches, it must be modified in the [c-implementation](../../main/c-implementation) as well to generate the same values.
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
