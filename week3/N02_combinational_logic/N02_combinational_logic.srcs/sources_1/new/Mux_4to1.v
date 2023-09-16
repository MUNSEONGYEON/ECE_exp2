`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 02:14:14
// Design Name: 
// Module Name: Mux_4to1
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


module Mux_4to1 (I0, I1, I2, I3, S0, S1, O);
input [3:0] I0, I1, I2, I3;
input S0, S1;
output [3:0] O;

assign O = S1 ? (S0 ? I3 : I2) : (S0 ? I1 : I0);

endmodule
