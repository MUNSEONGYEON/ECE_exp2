`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/20 15:39:04
// Design Name: 
// Module Name: JKFF_tb
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


module JKFF_tb();
reg clk, J, K;
wire Q;

JKFF U1 (clk, J, K, Q);

initial begin
    clk <= 0;
    #20 J <= 0; K <= 0;
    #20 J <= 0; K <= 1;
    #20 J <= 0; K <= 0;
    #20 J <= 1; K <= 0;
    #20 J <= 0; K <= 0;
    #20 J <= 1; K <= 1;
    #20 J <= 0; K <= 0;
end

always begin
    #5 clk = ~clk;
end

endmodule
