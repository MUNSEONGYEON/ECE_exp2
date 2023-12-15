`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/24 11:46:53
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(clk, rst, NORTH, SOUTH, WEST, EAST, WALK, add_1h, time_scope, EM_btn, LCD_E, LCD_RS, LCD_RW, LCD_DATA);
input clk, rst;
input add_1h, EM_btn;
input [2:0] time_scope;

output LCD_E, LCD_RS, LCD_RW;
output wire [7:0] LCD_DATA;
output reg [3:0] NORTH, SOUTH, WEST, EAST; // RED, YELLOW, GREEN, LEFT
output reg [7:0] WALK; // N_R, N_G, S_R, S_G, W_R, W_G, E_R, E_G

wire d_or_n;
wire add_1h_t, EM_btn_t;
wire [7:0] hour, min, sec;
reg [3:0] state;
reg [3:0] prev_state;
reg [3:0] EM_prev_state;
reg d_or_n_state;
reg EM_ON;

wire LCD_E;

parameter A = 4'b0000,
          B = 4'b0001,
          C = 4'b0010,
          D = 4'b0011,
          E = 4'b0100,
          F = 4'b0101,
          G = 4'b0110,
          H = 4'b0111,
          EM = 4'b1000;

integer cnt;
integer EM_cnt;

CLOCK C1(clk, rst, d_or_n, add_1h_t, time_scope, hour, min, sec);
oneshot_universal #(.WIDTH(2)) O1(clk, rst, {add_1h, EM_btn}, {add_1h_t, EM_btn_t});
LCD L1(clk, rst, hour, min, sec, d_or_n, state, LCD_E, LCD_RS, LCD_RW, LCD_DATA);

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        state = B;
        prev_state = H;
        cnt = 0;
        d_or_n_state = 1;
        EM_ON = 0;
    end
    else begin
        if(EM_btn_t) begin
            EM_ON = !EM_ON;
        end
        else begin
            if(d_or_n_state) begin // night
                case(state)
                    B : begin
                        if(cnt >= 10000) begin
                            if(!d_or_n) begin // day
                                state = A;
                                prev_state = E;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // night
                                state = A;
                                prev_state = B;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = B;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    A : begin
                        if(cnt >= 10000) begin
                            if(!d_or_n) begin // day
                                state = A;
                                prev_state = E;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // night
                                case(prev_state)
                                    B : begin
                                        state = C;
                                        prev_state = A;
                                        cnt = 0;
                                        d_or_n_state = d_or_n;
                                    end
                                    C : begin
                                        state = E;
                                        prev_state = A;
                                        cnt = 0;
                                        d_or_n_state = d_or_n;
                                    end
                                endcase
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = A;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    C : begin
                        if(cnt >= 10000) begin
                            if(!d_or_n) begin // day
                                state = A;
                                prev_state = E;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // night
                                state = A;
                                prev_state = C;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = C;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    E : begin
                        if(cnt >= 10000) begin
                            if(!d_or_n) begin // day
                                state = A;
                                prev_state = E;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // night
                                state = H;
                                prev_state = E;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = E;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    H : begin
                        if(cnt >= 10000) begin
                            if(!d_or_n) begin // day
                                state = A;
                                prev_state = E;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // night
                                state = B;
                                prev_state = H;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = H;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    EM : begin
                        if(cnt >= 15000) begin
                            if(!d_or_n) begin // day
                                state = EM_prev_state;
                                cnt = 0;
                                EM_ON = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // night
                                state = EM_prev_state;
                                cnt = 0;
                                EM_ON = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                endcase
            end



            else begin //day
                case(state)
                    A : begin
                        if(cnt >= 5000) begin
                            if(d_or_n) begin // night
                                state = B;
                                prev_state = H;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // day
                                state = D;
                                prev_state = A;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = A;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    D : begin
                        if(cnt >= 5000) begin
                            if(d_or_n) begin // night
                                state = B;
                                prev_state = H;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // day
                                state = F;
                                prev_state = D;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                       else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = D;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    F : begin
                        if(cnt >= 5000) begin
                            if(d_or_n) begin // night
                                state = B;
                                prev_state = H;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // day
                                state = E;
                                prev_state = F;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = F;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    E : begin
                        if(cnt >= 5000) begin
                            if(d_or_n) begin // night
                                state = A;
                                prev_state = E;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // day
                                case(prev_state)
                                F : begin
                                    state = G;
                                    prev_state = E;
                                    cnt = 0;
                                    d_or_n_state = d_or_n;
                                end
                                G : begin
                                    state = A;
                                    prev_state = E;
                                    cnt = 0;
                                    d_or_n_state = d_or_n;
                                end 
                                endcase
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = E;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    G : begin
                        if(cnt >= 5000) begin
                            if(d_or_n) begin // night
                                state = B;
                                prev_state = H;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // day
                                state = E;
                                prev_state = G;
                                cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else if(EM_ON) begin
                            if(EM_cnt >= 1000) begin
                                state = EM;
                                EM_prev_state = G;
                                cnt = 0;
                                EM_cnt = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin
                                EM_cnt = EM_cnt + 1;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                    EM : begin
                        if(cnt >= 15000) begin
                            if(!d_or_n) begin // day
                                state = EM_prev_state;
                                cnt = 0;
                                EM_ON = 0;
                                d_or_n_state = d_or_n;
                            end
                            else begin // night
                                state = EM_prev_state;
                                cnt = 0;
                                EM_ON = 0;
                                d_or_n_state = d_or_n;
                            end
                        end
                        else begin
                            cnt = cnt + 1;
                        end
                    end
                endcase
            end
        end
    end
end



always @(posedge clk or negedge rst) begin
    if(!rst) begin
        {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1111_1111_1111_1111_11_11_11_11;
    end
    else begin
        if(d_or_n_state) begin // night
            case(state)
                B : begin
                    if(cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_01;
                    if(cnt >= 5000 & cnt < 5500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_00; // 점멸 시작
                    if(cnt >= 5500 & cnt < 6000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_01;
                    if(cnt >= 6000 & cnt < 6500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_00;
                    if(cnt >= 6500 & cnt < 7000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_01;
                    if(cnt >= 7000 & cnt < 7500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_00;
                    if(cnt >= 7500 & cnt < 8000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_01;
                    if(cnt >= 8000 & cnt < 8500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_00;
                    if(cnt >= 8500 & cnt < 9000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0011_1000_1000_1000_10_10_10_01;
                    if(cnt >= 9000 & cnt < 9500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0110_1000_1000_1000_10_10_10_00; // 황색 신호 넣어주기
                    if(cnt >= 9500 & cnt < 10000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0110_1000_1000_1000_10_10_10_01;
                end
                A : begin
                    case(prev_state)
                        B : begin // B - A - C로 갈 때 YELLOW
                            if(cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 5000 & cnt < 5500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00; // 점멸 시작
                            if(cnt >= 5500 & cnt < 6000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 6000 & cnt < 6500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                            if(cnt >= 6500 & cnt < 7000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 7000 & cnt < 7500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                            if(cnt >= 7500 & cnt < 8000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 8000 & cnt < 8500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                            if(cnt >= 8500 & cnt < 9000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 9000 & cnt < 9500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0010_1000_1000_10_10_00_00; // 황색 신호 넣어주기
                            if(cnt >= 9500 & cnt < 10000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0010_1000_1000_10_10_01_01;
                        end
                        C : begin // C - A - E로 갈 때 YELLOW
                            if(cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 5000 & cnt < 5500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00; // 점멸 시작
                            if(cnt >= 5500 & cnt < 6000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 6000 & cnt < 6500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                            if(cnt >= 6500 & cnt < 7000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 7000 & cnt < 7500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                            if(cnt >= 7500 & cnt < 8000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 8000 & cnt < 8500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                            if(cnt >= 8500 & cnt < 9000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                            if(cnt >= 9000 & cnt < 9500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_00_00; // 황색 신호 넣어주기
                            if(cnt >= 9500 & cnt < 10000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_01_01;
                        end
                    endcase
                end
                C : begin
                    if(cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_01_10;
                    if(cnt >= 5000 & cnt < 5500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_00_10; // 점멸 시작
                    if(cnt >= 5500 & cnt < 6000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_01_10;
                    if(cnt >= 6000 & cnt < 6500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_00_10;
                    if(cnt >= 6500 & cnt < 7000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_01_10;
                    if(cnt >= 7000 & cnt < 7500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_00_10;
                    if(cnt >= 7500 & cnt < 8000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_01_10;
                    if(cnt >= 8000 & cnt < 8500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_00_10;
                    if(cnt >= 8500 & cnt < 9000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0011_1000_1000_10_10_01_10;
                    if(cnt >= 9000 & cnt < 9500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0110_1000_1000_10_10_00_10; // 황색 신호 넣어주기
                    if(cnt >= 9500 & cnt < 10000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_0110_1000_1000_10_10_01_10;
                end
                E : begin
                    if(cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                    if(cnt >= 5000 & cnt < 5500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_00_00_10_10; // 점멸 시작
                    if(cnt >= 5500 & cnt < 6000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                    if(cnt >= 6000 & cnt < 6500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_00_00_10_10;
                    if(cnt >= 6500 & cnt < 7000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                    if(cnt >= 7000 & cnt < 7500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_00_00_10_10;
                    if(cnt >= 7500 & cnt < 8000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                    if(cnt >= 8000 & cnt < 8500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_00_00_10_10;
                    if(cnt >= 8500 & cnt < 9000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                    if(cnt >= 9000 & cnt < 9500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0100_0100_00_00_10_10; // 황색 신호 넣어주기
                    if(cnt >= 9500 & cnt < 10000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0100_0100_01_01_10_10;
                end
                H : begin
                    if(cnt < 9000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0001_0001_10_10_10_10;
                    if(cnt >= 9000 & cnt < 10000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0100_0100_10_10_10_10; // 황색 신호 넣어주기
                end
                EM : begin
                    if(cnt < 7500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 7500 & cnt < 8000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00; // 점멸 시작
                    if(cnt >= 8000 & cnt < 8500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 8500 & cnt < 9000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 9000 & cnt < 9500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 9500 & cnt < 10000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 10000 & cnt < 10500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 10500 & cnt < 11000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 11000 & cnt < 11500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 11500 & cnt < 12000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 12000 & cnt < 12500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 12500 & cnt < 13000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 13000 & cnt < 13500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 13500 & cnt < 14000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 14000 & cnt < 14500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_01_01; // 황색 신호 넣어주기
                    if(cnt >= 14500 & cnt < 15000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_00_00;
                end
            endcase            
        end
        else begin // day
            case(state)
                A : begin
                    if(cnt < 2500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 2500 & cnt < 3000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00; // 점멸 시작
                    if(cnt >= 3000 & cnt < 3500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 3500 & cnt < 4000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 4000 & cnt < 4500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_01_01; // 황색 신호 넣어주기
                    if(cnt >= 4500 & cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_00_00;
                end
                D : begin
                    if(cnt < 4000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0001_0001_1000_1000_10_10_10_10;
                    if(cnt >= 4000 & cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_10_10; // 황색 신호 넣어주기
                end
                F : begin
                    if(cnt < 2500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0011_1000_01_10_10_10;
                    if(cnt >= 2500 & cnt < 3000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0011_1000_00_10_10_10; // 점멸 시작
                    if(cnt >= 3000 & cnt < 3500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0011_1000_01_10_10_10;
                    if(cnt >= 3500 & cnt < 4000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0011_1000_00_10_10_10;
                    if(cnt >= 4000 & cnt < 4500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0110_1000_01_10_10_10; // 황색 신호 넣어주기
                    if(cnt >= 4500 & cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0110_1000_00_10_10_10;
                end
                E : begin // E에서 G
                    case(prev_state)
                        F : begin // F - E - G로 갈 때 YELLOW
                            if(cnt < 2500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                            if(cnt >= 2500 & cnt < 3000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_00_00_10_10; // 점멸 시작
                            if(cnt >= 3000 & cnt < 3500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                            if(cnt >= 3500 & cnt < 4000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_00_00_10_10;
                            if(cnt >= 4000 & cnt < 4500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0100_0010_01_01_10_10; // 황색 신호 넣어주기
                            if(cnt >= 4500 & cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0100_0010_00_00_10_10;
                        end
                        G : begin // G - E - A로 갈 때 YELLOW
                            if(cnt < 2500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                            if(cnt >= 2500 & cnt < 3000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_00_00_10_10; // 점멸 시작
                            if(cnt >= 3000 & cnt < 3500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_01_01_10_10;
                            if(cnt >= 3500 & cnt < 4000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0010_0010_00_00_10_10;
                            if(cnt >= 4000 & cnt < 4500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0100_0100_01_01_10_10; // 황색 신호 넣어주기
                            if(cnt >= 4500 & cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_0100_0100_00_00_10_10;
                        end
                    endcase
                end
                G : begin
                    if(cnt < 2500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_1000_0011_10_01_10_10;
                    if(cnt >= 2500 & cnt < 3000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_1000_0011_10_00_10_10; // 점멸 시작
                    if(cnt >= 3000 & cnt < 3500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_1000_0011_10_01_10_10;
                    if(cnt >= 3500 & cnt < 4000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_1000_0011_10_00_10_10;
                    if(cnt >= 4000 & cnt < 4500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_1000_0110_10_01_10_10; // 황색 신호 넣어주기
                    if(cnt >= 4500 & cnt < 5000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b1000_1000_1000_0110_10_00_10_10;
                end
                EM : begin
                    if(cnt < 7500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 7500 & cnt < 8000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00; // 점멸 시작
                    if(cnt >= 8000 & cnt < 8500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 8500 & cnt < 9000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 9000 & cnt < 9500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 9500 & cnt < 10000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 10000 & cnt < 10500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 10500 & cnt < 11000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 11000 & cnt < 11500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 11500 & cnt < 12000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 12000 & cnt < 12500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 12500 & cnt < 13000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 13000 & cnt < 13500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_01_01;
                    if(cnt >= 13500 & cnt < 14000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0010_0010_1000_1000_10_10_00_00;
                    if(cnt >= 14000 & cnt < 14500) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_01_01; // 황색 신호 넣어주기
                    if(cnt >= 14500 & cnt < 15000) {NORTH, SOUTH, WEST, EAST, WALK} <= 24'b0100_0100_1000_1000_10_10_00_00;
                end
            endcase
        end
    end
end


endmodule