`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/08 18:31:45
// Design Name: 
// Module Name: logic_gate_tb
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


module logic_gate_tb();
reg a, b;
wire x1, x2, x3, x4, x5;

logic_gate u1(a, b, x1, x2, x3, x4, x5);

initial begin
        a = 1'b0; b = 1'b0;
    #10 a = 1'b0; b = 1'b1;
    #10 a = 1'b1; b = 1'b0;
    #10 a = 1'b1; b = 1'b1; 
end

endmodule
