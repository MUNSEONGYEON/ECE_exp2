`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/15 00:14:13
// Design Name: 
// Module Name: Priority_Encoder_4to2
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


module Priority_Encoder_4to2(in, out);
input [3:0] in;
output [1:0] out;
reg [1:0] out;

always @(*) begin
    casex(in)
        4'b0000 : out = 2'bxx;
        4'b1000 : out = 2'b00;
        4'bx100 : out = 2'b01;
        4'bxx10 : out = 2'b10;
        4'bxxx1 : out = 2'b11;
        default : out = 2'b00;
    endcase
end

endmodule
