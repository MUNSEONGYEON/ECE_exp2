`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/26 22:51:47
// Design Name: 
// Module Name: CLOCK
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


module CLOCK(clk, rst, d_or_n, add_1h_t, time_scope, hour, min, sec);
input clk, rst;
input add_1h_t;
input [2:0] time_scope;

reg [12:0] cnt;
output reg [7:0] hour, min, sec;
output reg d_or_n;

reg sec_one, sec_ten, min_one, min_ten, hour_one, hour_ten, day;
wire sec_one_t, sec_ten_t, min_one_t, min_ten_t, hour_one_t, hour_ten_t, day_t;

oneshot_universal #(.WIDTH(7)) O2(clk, rst, {sec_one, sec_ten, min_one, min_ten, hour_one, hour_ten, day}, 
                                            {sec_one_t, sec_ten_t, min_one_t, min_ten_t, hour_one_t, hour_ten_t, day_t});

always @(posedge clk or negedge rst) begin // 시간 배율
    if(!rst) begin
        cnt = 0;
        sec_one = 0;
    end
    else begin
        case(time_scope)
            3'b000 : begin
                if(cnt >= 1000) begin
                    cnt = 0;
                    sec_one = 1;
                end
                else begin
                    cnt = cnt + 1;
                    sec_one = 0;
                end
            end
            3'b100 : begin
                if(cnt >= 100) begin
                    cnt = 0;
                    sec_one = 1;
                end
                else begin
                    cnt = cnt + 1;
                    sec_one = 0;
                end
            end
            3'b010 : begin
                if(cnt >= 10) begin
                    cnt = 0;
                    sec_one = 1;
                end
                else begin
                    cnt = cnt + 1;
                    sec_one = 0;
                end
            end
            3'b001 : begin
                if(cnt >= 5) begin
                    cnt = 0;
                    sec_one = 1;
                end
                else begin
                    cnt = cnt + 1;
                    sec_one = 0;
                end
            end
        endcase
    end
end

always @(posedge clk or negedge rst) begin // 초 일의 자리
    if(!rst) begin
        sec[3:0] = 0;
        sec_ten = 0;
    end
    else begin
        if(sec_one_t) begin
            if(sec[3:0] == 9) begin
                sec[3:0] <= 0;
                sec_ten <= 1;
            end
            else begin
                sec[3:0] <= sec[3:0] + 1;
                sec_ten <= 0;
            end
        end
    end
end

always @(posedge clk or negedge rst) begin // 초 십의 자리
    if(!rst) begin
        sec[7:4] = 0;
        min_one = 0;
    end
    else begin
        if(sec_ten_t) begin
            if(sec[7:4] == 5) begin
                sec[7:4] <= 0;
                min_one <= 1;
            end
            else begin
                sec[7:4] <= sec[7:4] + 1;
                min_one <= 0;
            end
        end
    end
end

always @(posedge clk or negedge rst) begin // 분 일의 자리
    if(!rst) begin
        min[3:0] = 0;
        min_ten = 0;
    end
    else begin
        if(min_one_t) begin
             if(min[3:0] == 9) begin
                min[3:0] <= 0;
                min_ten <= 1;
            end
            else begin
                min[3:0] <= min[3:0] + 1;
                min_ten <= 0;
            end
        end
    end
end

always @(posedge clk or negedge rst) begin // 분 십의 자리
    if(!rst) begin
        min[7:4] = 0;
        hour_one = 0;
    end
    else begin
        if(min_ten_t) begin
             if(min[7:4] == 5) begin
                min[7:4] <= 0;
                hour_one <= 1;
            end
            else begin
                min[7:4] <= min[7:4] + 1;
                hour_one <= 0;
            end
        end
    end
end

always @(posedge clk or negedge rst) begin // 시 일의 자리
    if(!rst) begin
        hour[3:0] = 0;
        hour_ten = 0;
        day = 0;
    end
    else begin
        if(hour_one_t | add_1h_t) begin
             if(hour[3:0] == 9) begin
                hour[3:0] <= 0;
                hour_ten <= 1;
            end
            else begin
                if(hour[7:4] == 2 & hour[3:0] == 3) begin
                    hour[3:0] <= 0;
                    day <= 1;
                end
                else begin
                    hour[3:0] <= hour[3:0] + 1;
                    hour_ten <= 0;
                    day <= 0;
                end
            end
        end
    end
end

always @(posedge clk or negedge rst) begin // 시 일의 자리
    if(!rst) begin
        hour[7:4] = 0;
    end
    else begin
        if(day_t) begin
            hour[7:4] <= 0;
        end
        else if(hour_ten_t) begin
            hour[7:4] <= hour[7:4] + 1;
        end
    end
end

always @(posedge clk or negedge rst) begin // 주간 야간 구별
    if(!rst) begin
        d_or_n = 1;
    end
    else begin
        if(hour[7:4]*10 + hour[3:0] < 23 & hour[7:4]*10 + hour[3:0] >= 8) begin
            d_or_n <= 0;
        end
        else begin
            d_or_n <= 1;
        end
    end
end

endmodule