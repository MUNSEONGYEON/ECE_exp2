`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/18 02:35:23
// Design Name: 
// Module Name: DAC_tb
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


module DAC_tb();
reg clk,rst, add_sel;
reg [8:0] btn;
wire dac_csn, dac_ldacn, dac_wrn, dac_a_b;
wire [7:0] dac_d;
wire [7:0] led_out;
wire LCD_E, LCD_RS, LCD_RW;
wire [7:0] LCD_DATA;
wire [7:0] seg_data;
wire [7:0] seg_sel;


DAC U1 (clk, rst, btn, add_sel, dac_csn, dac_ldacn, dac_wrn, dac_a_b, dac_d, led_out, LCD_E, LCD_RS, LCD_RW, LCD_DATA, seg_data, seg_sel);

initial begin
   clk <= 0;
   rst <= 1;
   add_sel <= 0;
   btn = 9'b000000000;
   #1e+6 rst <= 0;
   #1e+6 rst <= 1;
   #1e+5 btn = 9'b000000001;
   #1e+5 btn = 9'b000000100;
   #1e+5 btn = 9'b000001000;
   #1e+5 btn = 9'b000100000;
   #1e+5 btn = 9'b001000000;
   #1e+5 btn = 9'b100000000;
end
 
always begin
    #0.5 clk = ~clk;
end

endmodule
