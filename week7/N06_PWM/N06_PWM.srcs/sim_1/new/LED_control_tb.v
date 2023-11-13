`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/08 01:24:49
// Design Name: 
// Module Name: LED_control_tb
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


module LED_control_tb();
reg clk, rst;
reg [7:0] bin;
wire led_signal;

LED_control U1 (clk, rst, bin, seg_data, seg_sel, led_signal);

initial begin
    clk <= 0;
    rst <= 0;
    bin <= 8'b00000000;
    #1e+6; rst <= 1;
    #1e+6; rst <= 0;
    #1e+6; bin <= 8'b01000000;
    #1e+6; bin <= 8'b10000000;
    #1e+6; bin <= 8'b10111111;
    #1e+6; bin <= 8'b11111111;
end

always begin
    #0.5 clk = ~clk;
end

endmodule
