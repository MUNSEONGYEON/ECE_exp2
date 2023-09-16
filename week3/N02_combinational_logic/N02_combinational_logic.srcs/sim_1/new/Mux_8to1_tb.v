`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 12:26:25
// Design Name: 
// Module Name: Mux_8to1_tb
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


module Mux_8to1_tb();
reg [3:0] I0, I1, I2, I3, I4, I5, I6, I7;
reg S0, S1, S2;
wire [3:0] O;

Mux_8to1 U4 (I0, I1, I2, I3, I4, I5, I6, I7, S0, S1, S2, O);

initial begin
    I0 = 4'b1001;
    I1 = 4'b1100;
    I2 = 4'b1011;
    I3 = 4'b0000;
    I4 = 4'b0101;
    I5 = 4'b1000;
    I6 = 4'b0111;
    I7 = 4'b1101;

    #10 S2 = 0; S1 = 0; S0 = 0;
    #10 S2 = 0; S1 = 0; S0 = 1;
    #10 S2 = 0; S1 = 1; S0 = 0;
    #10 S2 = 0; S1 = 1; S0 = 1;
    #10 S2 = 1; S1 = 0; S0 = 0;
    #10 S2 = 1; S1 = 0; S0 = 1;
    #10 S2 = 1; S1 = 1; S0 = 0;
    #10 S2 = 1; S1 = 1; S0 = 1;
end

endmodule
