`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/20 15:04:58
// Design Name: 
// Module Name: DFF_tb
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


module DFF_tb();
reg clk, D;
wire Q;

DFF U1 (clk, D, Q);

initial begin
    clk <= 0;
    #20 D <= 0;
    #20 D <= 1;
    #20 D <= 0;
    #20 D <= 1;
    #20 D <= 0;
    #20 D <= 1;
end
always begin
    #5 clk = ~clk;
end
endmodule
