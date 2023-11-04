`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 17:50:03
// Design Name: 
// Module Name: seg_array_tb
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


module seg_array_tb();
reg clk, rst, btn;
wire [7:0] seg_data; 
wire [7:0] seg_sel;
wire [3:0] state_bin;

seg_array U1 (clk, rst, btn, seg_data, seg_sel);

initial begin
    clk <= 0;
    rst <= 1;
    btn <= 0;
    #10 rst <= 0;
    #10 rst <= 1;
    #12 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
    #30 btn <= 1;
    #2 btn <= 0;
end
always begin
    #2 clk = ~clk;
end

endmodule
