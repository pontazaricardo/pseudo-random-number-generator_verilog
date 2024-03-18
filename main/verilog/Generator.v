`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Pontaza
// 
// Create Date: 03/16/2024 05:44:35 PM
// Design Name: 
// Module Name: Generator
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


module Generator(seed, generatedRandom);
    
    input [31:0] seed;
    output [31:0] generatedRandom;
    
    wire [15:0] middleBits = seed[23:8];
    wire [31:0] randomCandidate = middleBits * middleBits;

    assign generatedRandom = randomCandidate;
    
endmodule
