`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/27 09:15:46
// Design Name: 
// Module Name: LCD
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


module LCD(clk, rst, hour, min, sec, d_or_n, t_state, LCD_E, LCD_RS, LCD_RW, LCD_DATA);
input clk, rst, d_or_n;
input [3:0] t_state;
input [7:0] hour, min, sec; 

output LCD_E, LCD_RS, LCD_RW;
output reg [7:0] LCD_DATA;

wire LCD_E;
reg LCD_RS, LCD_RW;
reg LCD_text;

reg [2:0] state; 
parameter DELAY = 3'b000,
          FUNCTION_SET = 3'b001,
          ENTRY_MODE = 3'b010,
          DISP_ONOFF = 3'b011,
          LINE1 = 3'b100,
          LINE2 = 3'b101,
          DELAY_T = 3'b110,
          CLEAR_DISP = 3'b111;

integer cnt;

always @(posedge clk or negedge rst) begin
    if(!rst) state = DELAY;
    else begin
        case(state)
            DELAY : begin
                if(cnt == 70) state = FUNCTION_SET;
            end
            FUNCTION_SET : begin
                if(cnt == 30) state = DISP_ONOFF;
            end
            DISP_ONOFF : begin
                if(cnt == 30) state = ENTRY_MODE;
            end
            ENTRY_MODE : begin
                if(cnt == 30) state = LINE1;
            end
            LINE1 : begin
                if(cnt == 20) state = LINE2;
            end
            LINE2 : begin
                if(cnt == 20) state = DELAY_T;
            end
            DELAY_T : begin
                if(cnt == 300) state = CLEAR_DISP;
            end
            CLEAR_DISP : begin
                if(cnt == 5) state = LINE1;
            end
            default : state = DELAY;
        endcase
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) cnt = 0;
    else begin
        case(state)
            DELAY :
                if (cnt >= 70) cnt = 0;
                else cnt = cnt + 1;
            FUNCTION_SET :
                if (cnt >= 30) cnt = 0;
                else cnt = cnt + 1;
            DISP_ONOFF :
                if (cnt >= 30) cnt = 0;
                else cnt = cnt + 1;
            ENTRY_MODE :
                if (cnt >= 30) cnt = 0;
                else cnt = cnt + 1;
            LINE1 :
                if (cnt >= 20) cnt = 0;
                else cnt = cnt + 1;
            LINE2 :
                if (cnt >= 20) cnt = 0;
                else cnt = cnt + 1;
            DELAY_T :
                if (cnt >= 300) cnt = 0;
                else cnt = cnt + 1;
            CLEAR_DISP :
                if (cnt >= 5) cnt = 0;
                else cnt = cnt + 1;
            default : state = DELAY;
        endcase
    end
end

always @(posedge clk or negedge rst)
begin
    if(!rst) 
        {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_00000000;
    else begin
        case(state)
            FUNCTION_SET :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_1000;
            DISP_ONOFF :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_1100;
            ENTRY_MODE :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0110;
            LINE1 : begin
                case(cnt)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1000_0000;
                    01 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0100; // T
                    02 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_1001; // i
                    03 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_1101; // m
                    04 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0101; // e
                    05 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    06 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1010; // :
                    07 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000;
                    08 : begin // 시 십의 자리
                        case(hour[7:4])
                            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; 
                            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
                            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010;
                        endcase
                    end
                    09 : begin // 시 일의 자리
                        case(hour[3:0])
                            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000;
                            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001;
                            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010;
                            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011;
                            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100;
                            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101;
                            6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110;
                            7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111;
                            8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000;
                            9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001;
                        endcase
                    end
                    10 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1010; // :
                    11 : begin // 분 십의 자리
                        case(min[7:4])
                            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000;
                            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001;
                            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010;
                            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011;
                            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100;
                            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101;
                        endcase
                    end
                    12 : begin // 분 일의 자리
                        case(min[3:0])
                            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000;
                            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001;
                            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010;
                            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011;
                            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100;
                            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101;
                            6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110;
                            7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111;
                            8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000;
                            9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001;
                         endcase
                     end
                     13 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1010; // :
                     14 : begin // 초 십의 자리
                        case(sec[7:4])
                            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000;
                            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001;
                            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010;
                            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011;
                            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100;
                            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101;
                        endcase
                    end
                    15 : begin // 초 일의 자리
                        case(sec[3:0])
                            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000;
                            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001;
                            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010;
                            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011;
                            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100;
                            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101;
                            6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110;
                            7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111;
                            8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000;
                            9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001;
                        endcase
                    end
                    default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                endcase
            end
            LINE2 : begin
                case(cnt)
                    00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1100_0000;
                    01 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0011; // S
                    02 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0111_0100; // t
                    03 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0001; // a
                    04 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0111_0100; // t
                    05 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0101; // e
                    06 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                    07 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1010; // :
                    08 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //  
                    09 : begin // state
                        case(t_state)
                            0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0001; // A
                            1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0010; // B
                            2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0011; // C
                            3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0100; // D
                            4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0101; // E
                            5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0110; // F
                            6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0111; // G
                            7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1000; // H
                            8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0001; // A
                        endcase
                    end
                    10 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_1000; // (
                    11 : {LCD_RS, LCD_RW, LCD_DATA} = d_or_n ? 10'b1_0_0110_1110 : 10'b1_0_0110_0100;// n / d
                    12 : {LCD_RS, LCD_RW, LCD_DATA} = d_or_n ? 10'b1_0_0110_1001 : 10'b1_0_0110_0001;// i / a
                    13 : {LCD_RS, LCD_RW, LCD_DATA} = d_or_n ? 10'b1_0_0110_0111 : 10'b1_0_0111_1001;// g / y
                    14 : {LCD_RS, LCD_RW, LCD_DATA} = d_or_n ? 10'b1_0_0110_1000 : 10'b1_0_0010_1001;// h / )
                    15 : {LCD_RS, LCD_RW, LCD_DATA} = d_or_n ? 10'b1_0_0111_0100 : 10'b1_0_0010_0000;// t / _
                    16 : {LCD_RS, LCD_RW, LCD_DATA} = d_or_n ? 10'b1_0_0010_1001 : 10'b1_0_0010_0000;// ) / _
                    default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //
                endcase
            end
            DELAY_T : 
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0010;
            CLEAR_DISP :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0001;
            default :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_0010_0000;
         endcase
     end
end

assign LCD_E = clk;

endmodule