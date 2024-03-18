`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2024 10:01:10 PM
// Design Name: 
// Module Name: xorshifter_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module xorshifter_testbench;

    reg [31:0] recurrentSeed;
    wire [31:0] generatedRandom;
    
    XORShifter xorshifter (recurrentSeed, generatedRandom);

    initial begin
    
        #0 recurrentSeed = 32'd20240301;
        forever
        #10 recurrentSeed = generatedRandom;
    end
endmodule
