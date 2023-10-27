`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/27 18:12:06
// Design Name: 
// Module Name: updown_counter_3bit_tb
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


module updown_counter_3bit_tb();
reg clk, rst, x;
wire [2:0] state;

updown_counter_3bit U1 (clk, rst, x, state);

initial begin
    clk <= 0;
    rst <= 1;
    x <= 0;
    #10 rst <= 0;
    #10 rst <= 1;
    #80 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
    #10 x <= 0;
    #20 x <= 1;
end
always begin
    #5 clk = ~clk;
end
endmodule