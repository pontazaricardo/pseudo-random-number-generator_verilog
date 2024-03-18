`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Pontaza
// 
// Create Date: 03/17/2024 09:56:23 PM
// Design Name: 
// Module Name: XORShifter
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

module XORShifter(seed, generatedRandom);
    
    input [31:0] seed;
    output [31:0] generatedRandom;
    
    wire [31:0] step01 = seed ^ seed >> 7;
    wire [31:0] step02 = step01 ^ step01 << 9;
    assign generatedRandom  = step02 ^ step02 >>13;
    
endmodule
