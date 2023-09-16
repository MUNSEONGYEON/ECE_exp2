`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 02:11:28
// Design Name: 
// Module Name: Mux_2to1
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


module Mux_2to1 (I0, I1, S, O);
input [3:0] I0, I1;
input S;
output [3:0] O;

assign O = (S ? I1 : I0);

endmodule
