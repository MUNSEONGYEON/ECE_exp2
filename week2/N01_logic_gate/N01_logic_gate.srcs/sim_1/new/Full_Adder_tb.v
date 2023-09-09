`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/08 23:14:19
// Design Name: 
// Module Name: Full_adder_tb
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


module Full_Adder_tb();
reg A, B, Cin;
wire S, Cout;

Full_Adder U1(A, B, Cin, S, Cout);

initial begin
        A = 1'b0; B = 1'b0; Cin = 1'b0;
    #10 A = 1'b0; B = 1'b0; Cin = 1'b1;
    #10 A = 1'b0; B = 1'b1; Cin = 1'b0;
    #10 A = 1'b0; B = 1'b1; Cin = 1'b1;
    #10 A = 1'b1; B = 1'b0; Cin = 1'b0;
    #10 A = 1'b1; B = 1'b0; Cin = 1'b1;
    #10 A = 1'b1; B = 1'b1; Cin = 1'b0;
    #10 A = 1'b1; B = 1'b1; Cin = 1'b1;
end

endmodule
