`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/14 19:17:57
// Design Name: 
// Module Name: Four_Bit_Comparator
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


module Four_Bit_Comparator(a, b, x, y, z);
input [3:0] a, b;
output x, y, z;
wire x, y, z;

assign x = (a > b) ? 1'b1 : 1'b0;

assign y = (a == b) ? 1'b1 : 1'b0;

assign z = (a < b) ? 1'b1 : 1'b0;

endmodule
