`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/20 01:33:15
// Design Name: 
// Module Name: seg_array_DAC
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


module seg_array_DAC(clk, rst, dac_d, seg_data, seg_sel);
input clk, rst;
input [7:0] dac_d;
output reg [7:0] seg_data;
output reg [7:0] seg_sel;

reg dac_di;

always @(posedge clk or negedge rst) begin
    if(!rst) seg_sel <= 8'b11111110;
    else begin
        seg_sel <= {seg_sel[6:0], seg_sel[7]};
    end
end

always @(*) begin
    case(dac_di)
        0 : seg_data = 8'b11111100;
        1 : seg_data = 8'b01100000;
        default : seg_data = 8'b00000000;
     endcase
end

always @(*) begin
    case(seg_sel)
        8'b11111110 : dac_di = dac_d[0];
        8'b11111101 : dac_di = dac_d[1];
        8'b11111011 : dac_di = dac_d[2];
        8'b11110111 : dac_di = dac_d[3];
        8'b11101111 : dac_di = dac_d[4];
        8'b11011111 : dac_di = dac_d[5];
        8'b10111111 : dac_di = dac_d[6];
        8'b01111111 : dac_di = dac_d[7];
        default : dac_di = 1'b0;
    endcase
end

endmodule