`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/18 02:27:42
// Design Name: 
// Module Name: DAC
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


module DAC(clk, rst, btn, add_sel, dac_csn, dac_ldacn, dac_wrn, dac_a_b, dac_d, led_out, LCD_E, LCD_RS, LCD_RW, LCD_DATA, seg_data, seg_sel);

input clk, rst;
input [8:0] btn;
input add_sel;
output reg dac_csn, dac_ldacn, dac_wrn, dac_a_b;
output reg [7:0] dac_d;
output reg [7:0] led_out;

reg [7:0] dac_d_temp;
reg [7:0] cnt;
wire [8:0] btn_t;

reg [1:0] state;

parameter DELAY = 2'b00, SET_WRN = 2'b01, UP_DATA =2'b10;

oneshot_universal #(.WIDTH(9)) O1(clk, rst, {btn[8:0]}, {btn_t[8:0]});

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        state <= DELAY;
    end
    else begin
        case(state)
            DELAY : if(cnt==200) state <= SET_WRN;
            SET_WRN : if(cnt==50) state <= UP_DATA;
            UP_DATA : if(cnt==30) state <= DELAY;
        endcase
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst)
        cnt <= 8'b0000_0000;
    else begin
        case(state)
            DELAY : 
                if(cnt>=200) cnt<=0;
                else cnt <= cnt + 1;
            SET_WRN :                 
                if(cnt>=50) cnt<=0;
                else cnt <= cnt + 1;
            UP_DATA : 
                if(cnt>=30) cnt<=0;
                else cnt <= cnt + 1;
        endcase
    end
end


always @(posedge clk or negedge rst) begin
    if(!rst) begin
        dac_wrn <= 1;
    end
    else begin
        case(state)
            DELAY : 
                dac_wrn <= 1;
        SET_WRN :                 
                dac_wrn <= 0;
        UP_DATA : 
                dac_d <= dac_d_temp;
        endcase
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        dac_d_temp <= 8'b0000_0000;
        led_out <= 8'b0101_0101;
    end
    else begin
        if(btn_t == 9'b100000000) dac_d_temp <= dac_d_temp -  8'b0000_0001; 
        else if(btn_t == 9'b001000000) dac_d_temp <= dac_d_temp +  8'b0000_0001; 
        else if(btn_t == 9'b000100000) dac_d_temp <= dac_d_temp -  8'b0000_0010;
        else if(btn_t == 9'b000001000) dac_d_temp <= dac_d_temp +  8'b0000_0010;
        else if(btn_t == 9'b000000100) dac_d_temp <= dac_d_temp -  8'b0000_1000;
        else if(btn_t == 9'b000000001) dac_d_temp <= dac_d_temp +  8'b0000_1000;
        led_out <= dac_d_temp;
    end
end

always @(posedge clk) begin
    dac_csn <= 0;
    dac_ldacn <= 0;
    dac_a_b <= add_sel; // 0 : select A, 1 : select B
end





output LCD_E, LCD_RS, LCD_RW;
output reg [7:0] LCD_DATA;

wire LCD_E;
reg LCD_RS, LCD_RW;

reg [2:0] state_2;
parameter DELAY_2      = 3'b000,
          FUNCTION_SET = 3'b001,
          ENTRY_MODE   = 3'b010,
          DISP_ONOFF   = 3'b011,
          LINE1        = 3'b100,
          LINE2        = 3'b101,
          DELAY_T      = 3'b110,
          CLEAR_DISP   = 3'b111;
          
integer cnt_2;

always @(posedge clk or negedge rst)
begin
    if(!rst)begin
        state_2 = DELAY_2;
        cnt_2 = 0;
    end
    else begin
        case(state_2)
            DELAY_2 : begin
                if(cnt_2 == 70) state_2 = FUNCTION_SET;
                if(cnt_2 >= 70) cnt_2 = 0;
                else cnt_2 = cnt_2 + 1;
            end
            FUNCTION_SET:begin

                if(cnt_2 == 30) state_2 = DISP_ONOFF;
                if(cnt_2 >= 30) cnt_2 = 0;
                else cnt_2 = cnt_2 + 1;

            end
            DISP_ONOFF:begin

                if(cnt_2 == 30) state_2 = ENTRY_MODE;
                if(cnt_2 >= 30) cnt_2 = 0;
                else cnt_2 = cnt_2 + 1;

            end
            ENTRY_MODE:begin

                if(cnt_2 == 30) state_2 = LINE1;
                 if(cnt_2 >= 30) cnt_2 = 0;
                else cnt_2 = cnt_2 + 1;

            end
            LINE1:begin

                if(cnt_2 == 20) state_2 = LINE2;
                if(cnt_2 >= 20) cnt_2 = 0;
                else cnt_2 = cnt_2 + 1;

            end
            LINE2:begin

                if(cnt_2 == 20) state_2 = DELAY_T;
                if(cnt_2 >= 20) cnt_2 = 0;
                else cnt_2 = cnt_2 + 1;

            end
            DELAY_T:begin
                if(cnt_2 == 5) state_2 = CLEAR_DISP;
                if(cnt_2 >= 5) cnt_2 = 0;
                else cnt_2 = cnt_2 + 1;

            end
            CLEAR_DISP:begin
                if(cnt_2 == 5) state_2 = LINE1;
                 if(cnt_2 >= 5) cnt_2 = 0;
                else cnt_2 = cnt_2 + 1;

            end
            default: state_2 = DELAY_2;
        endcase
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_00000000;
    else begin
        case(state_2)
            FUNCTION_SET :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_1000;
            DISP_ONOFF :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_1100;
            ENTRY_MODE :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0110;
            LINE1 : begin
                case(cnt_2)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1000_0000;
                    01 : {LCD_RS, LCD_RW, LCD_DATA} = {9'b1_0_0011_000, dac_d[7]}; //
                    02 : {LCD_RS, LCD_RW, LCD_DATA} = {9'b1_0_0011_000, dac_d[6]}; //
                    03 : {LCD_RS, LCD_RW, LCD_DATA} = {9'b1_0_0011_000, dac_d[5]}; //
                    04 : {LCD_RS, LCD_RW, LCD_DATA} = {9'b1_0_0011_000, dac_d[4]}; //
                    05 : {LCD_RS, LCD_RW, LCD_DATA} = {9'b1_0_0011_000, dac_d[3]}; //
                    06 : {LCD_RS, LCD_RW, LCD_DATA} = {9'b1_0_0011_000, dac_d[2]}; //
                    07 : {LCD_RS, LCD_RW, LCD_DATA} = {9'b1_0_0011_000, dac_d[1]}; ///
                    08 : {LCD_RS, LCD_RW, LCD_DATA} = {9'b1_0_0011_000, dac_d[0]}; //
                    09 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    10 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    11 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    12 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    13 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    14 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    15 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    16 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                endcase
            end
            LINE2 : begin
                case(cnt_2)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1100_0000;
                    01 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; // 2
                    02 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; // 0
                    03 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; // 2
                    04 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; // 0
                    05 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; // 4
                    06 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; // 4
                    07 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; // 0
                    08 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; // 0
                    09 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; // 4
                    10 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110; // 6
                    11 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    12 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1101; // M
                    13 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0011; // S
                    14 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_1001; // Y
                    15 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    16 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                endcase
            end
            DELAY_T :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0010;
            CLEAR_DISP :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0001;
            default :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_0000_0000;
        endcase
    end
end

assign LCD_E = clk;





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