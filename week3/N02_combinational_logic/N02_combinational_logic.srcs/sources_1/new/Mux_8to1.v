`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/15 00:50:42
// Design Name: 
// Module Name: Mux_8to1
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


module Mux_8to1 (I0, I1, I2, I3, I4, I5, I6, I7, S0, S1, S2, O);
input [3:0] I0, I1, I2, I3, I4, I5, I6, I7;
input S0, S1, S2;
output [3:0] O;
wire [3:0] M1, M2;

Mux_4to1 U1 (.I0(I0), .I1(I1), .I2(I2), .I3(I3), .S0(S0), .S1(S1), .O(M1));
Mux_4to1 U2 (.I0(I4), .I1(I5), .I2(I6), .I3(I7), .S0(S0), .S1(S1), .O(M2));
Mux_2to1 U3 (.I0(M1), .I1(M2), .S(S2), .O(O));

endmodule
