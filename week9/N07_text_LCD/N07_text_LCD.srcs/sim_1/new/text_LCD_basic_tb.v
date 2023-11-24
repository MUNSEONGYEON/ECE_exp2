`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/09 16:37:38
// Design Name: 
// Module Name: text_LCD_basic_tb
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


module text_LCD_basic_tb();
reg clk, rst;
wire LCD_E, LCD_RS, LCD_RW;
wire [7:0] LCD_DATA;
wire [7:0] LED_out;

text_LCD_basic1 U1 (rst, clk, LCD_E, LCD_RS, LCD_RW, LCD_DATA, LED_out);

initial begin
    clk <= 0;
    rst <= 1;
    #1e+6 rst <= 0;
    #1e+6 rst <= 1;
end

always begin
    #0.5 clk = ~clk;
end

endmodule
