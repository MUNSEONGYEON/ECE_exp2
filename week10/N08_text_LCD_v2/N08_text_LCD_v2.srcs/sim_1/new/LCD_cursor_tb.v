`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/14 14:34:53
// Design Name: 
// Module Name: LCD_cursor_tb
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


module LCD_cursor_tb();
reg clk, rst;
reg [9:0] number_btn;
reg [1:0] control_btn;
wire LCD_E, LCD_RS, LCD_RW;
wire [7:0] LCD_DATA;
wire [7:0] LED_out;

LCD_cursor U1 (rst, clk, LCD_E, LCD_RS, LCD_RW, LCD_DATA, LED_out, number_btn, control_btn);

initial begin
    clk <= 0;
    rst <= 1;
    number_btn <= 10'b0;
    control_btn <= 0;
    #1e+6 rst <= 0;
    #1e+6 rst <= 1;
    #1e+6 number_btn <= 10'b0001000000;
    #1e+6 control_btn <= 2'b10;
    #1e+6 number_btn <= 10'b0000010000;
    #1e+6 control_btn <= 2'b01;
end

always begin
    #0.5 clk = ~clk;
end

endmodule
