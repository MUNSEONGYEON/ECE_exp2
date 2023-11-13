`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/08 01:28:05
// Design Name: 
// Module Name: LED3_control_tb
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


module LED3_control_tb();
reg clk, rst;
reg [7:0] btn;
wire [3:0] led_signal_R;
wire [3:0] led_signal_G;
wire [3:0] led_signal_B;

LED3_control U1 (clk, rst, btn, led_signal_R, led_signal_G, led_signal_B);

initial begin
    clk <= 0;
    rst <= 0;
    btn <= 8'b00000000;
    #1e+6; rst <= 1;
    #1e+6; rst <= 0;
    #1e+6; btn <= 8'b00000001;
    #1e+6; btn <= 8'b00000010;
    #1e+6; btn <= 8'b00000100;
end

always begin
    #0.5 clk = ~clk;
end

endmodule
