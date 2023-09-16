`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 13:26:38
// Design Name: 
// Module Name: Mux_4to1_2bit
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


module Mux_4to1_2bit(I0, I1, I2, I3, S0, S1, O);
input [1:0] I0, I1, I2, I3;
input S0, S1;
output [1:0] O;

assign O = S1 ? (S0 ? I3 : I2) : (S0 ? I1 : I0);

endmodule
