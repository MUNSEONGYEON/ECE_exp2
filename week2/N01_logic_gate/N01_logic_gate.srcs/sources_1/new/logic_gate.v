`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/08 17:46:27
// Design Name: 
// Module Name: logic_gate
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


module logic_gate (a, b, x1, x2, x3, x4, x5);

input a, b;
output x1, x2, x3, x4, x5;
wire x1, x2, x3, x4, x5;

//and gate
assign x1 = a & b;
//or gate
assign x2 = a | b;
//xor gate
assign x3 = a ^ b;
//nor gate
assign x4 = ~(a | b);
//nand gate
assign x5 = ~(a & b);

endmodule