`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/15 00:28:41
// Design Name: 
// Module Name: Priority_Encoder_4to2_tb
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


module Priority_Encoder_4to2_tb();
reg [3:0] in;
wire [1:0] out;

Priority_Encoder_4to2 U1 (in, out);

initial begin
        in = 4'b0000;
    #10 in = 4'b1000;
    #10 in = 4'b1011;
    #10 in = 4'b0101;
    #10 in = 4'b0001;

end

endmodule
