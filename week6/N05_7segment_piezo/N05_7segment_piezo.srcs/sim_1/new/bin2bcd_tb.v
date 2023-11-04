`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 16:24:52
// Design Name: 
// Module Name: bin2bcd_tb
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


module bin2bcd_tb();
reg clk, rst;
reg [3:0] bin;
wire [7:0] bcd;

bin2bcd U1 (clk, rst, bin, bcd);

initial begin
    clk <= 0;
    rst <= 1;
    bin <= 4'b0000;
    #10 rst <= 0;
    #10 rst <= 1;
    #20 bin <= 4'b0011;
    #20 bin <= 4'b1000;
    #20 bin <= 4'b0111;
    #20 bin <= 4'b0000;
end
always begin    
    #5 clk = ~clk;
end
endmodule
