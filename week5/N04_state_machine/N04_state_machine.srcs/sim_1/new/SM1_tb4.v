`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 13:59:37
// Design Name: 
// Module Name: SM1_tb4
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


module SM1_tb4();
reg clk, rst, x;
wire y;

SM1 U4 (clk, rst, x, y, state);

initial begin
    clk <= 0;
    rst <= 1;
    x <= 0;
    #10 rst <= 0;
    #10 rst <= 1;
    #20 x <= 1;
    #20 x <= 0;
end
always begin
    #5 clk = ~clk;
end

endmodule
