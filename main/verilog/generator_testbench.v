`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Pontaza
// 
// Create Date: 03/16/2024 05:51:26 PM
// Design Name: 
// Module Name: generator_testbench
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


module generator_testbench;

    reg [31:0] recurrentSeed;
    wire [31:0] generatedRandom;
    
    Generator generator (recurrentSeed, generatedRandom);

    initial begin
    
        #0 recurrentSeed = 32'd20240301;
        forever
        #10 recurrentSeed = generatedRandom;
    end

endmodule
