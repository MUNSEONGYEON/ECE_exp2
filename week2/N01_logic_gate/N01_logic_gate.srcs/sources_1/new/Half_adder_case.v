`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/08 22:35:47
// Design Name: 
// Module Name: Half_adder_case
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


module Half_Adder_case(A, B, C, S);
input A, B;
output C, S;
reg  C, S;

always @(*) begin

case({A, B})
    2'b00 : {C, S} = 2'b00;
    2'b01 : {C, S} = 2'b01;
    2'b10 : {C, S} = 2'b01;
    2'b11 : {C, S} = 2'b10;
    default : {C, S} = 2'b00;
endcase
end
endmodule
