`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/08 16:15:08
// Design Name: 
// Module Name: SM2_tb
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


module SM2_tb();
reg clk, rst, A, B, C;
wire y;

SM2 U1 (clk, rst, A, B, C, state, y);

initial begin
    clk <= 0;
    rst <= 1;
    {A, B, C} <= 3'b000;
    #10 rst <= 0;
    #10 rst <= 1;
    #20 {A, B, C} <= 3'b100;
    #20 {A, B, C} <= 3'b010;
    #20 {A, B, C} <= 3'b100;
    #20 {A, B, C} <= 3'b010;
    #20 {A, B, C} <= 3'b001;
    #20 rst <= 0;
    #10 rst <= 1;
    #20 {A, B, C} <= 3'b100;
    #20 {A, B, C} <= 3'b010;
    #20 {A, B, C} <= 3'b001;    
end 
always begin
    #5 clk = ~clk;
end

endmodule