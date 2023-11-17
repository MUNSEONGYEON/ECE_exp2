`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/14 12:10:53
// Design Name: 
// Module Name: oneshot_universial
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


module oneshot_universial(clk, rst, btn, btn_trig);
parameter WIDTH = 1;
input clk, rst;
input [WIDTH-1:0] btn;
reg [WIDTH-1:0] btn_reg;
output reg [WIDTH-1:0] btn_trig;

always @(negedge rst or posedge clk) begin
    if(!rst) begin
        btn_reg <= {WIDTH{1'b0}};
        btn_trig <= {WIDTH{1'b0}};
    end
    else begin
        btn_reg <= btn;
        btn_trig <= btn & ~btn_reg;    
    end
end

endmodule
