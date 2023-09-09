`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/08 22:54:17
// Design Name: 
// Module Name: Full_Adder
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


module Full_Adder(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
wire S1, C1, C2;

Half_Adder u1 (A, B, C1, S1);
Half_Adder u2 (S1, Cin, C2, S);

assign Cout = C1 | C2;

endmodule
