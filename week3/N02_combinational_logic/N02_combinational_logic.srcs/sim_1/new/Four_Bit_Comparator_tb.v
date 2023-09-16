`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/14 22:28:18
// Design Name: 
// Module Name: Four_Bit_Comparator_tb
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


module Four_Bit_Comparator_tb();
reg [3:0] a, b;
wire x, y, z;

Four_Bit_Comparator U1 (a, b, x, y, z);

initial begin
        a = 4'b0011; b = 4'b1000;
    #10 a = 4'b0111; b = 4'b0001;
    #10 a = 4'b1001; b = 4'b1001;
    #10 a = 4'b1011; b = 4'b1111;
end

endmodule
