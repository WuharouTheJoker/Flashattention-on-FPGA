`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/19 04:12:07
// Design Name: 
// Module Name: tb_os_pe
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

module tb_os_pe;



    // Inputs
    reg clk;
    reg rst_n;
    reg [15:0] p_in;
    reg p_in_valid;
    reg p_last_in;
    reg [15:0] v_in;
    reg v_in_valid;


    // Outputs
    wire [15:0] o_out;
    wire o_out_valid;
    wire [15:0] p_out;
    wire p_out_valid;
    wire p_last_out;
    wire [15:0] o_result_out;
    wire o_result_out_valid;

    // Instantiate DUT
    os_pe dut (
        .clk(clk),
        .rst_n(rst_n),
        .p_in(p_in),
        .p_in_valid(p_in_valid),
        .p_last_in(p_last_in),
        .v_in(v_in),
        .v_in_valid(v_in_valid),
        // .o_out(o_out),
        // .o_out_valid(o_out_valid),
        .p_out(p_out),
        .p_out_valid(p_out_valid),
        .p_last_out(p_last_out),
        .o_result_out(o_result_out),
        .o_result_out_valid(o_result_out_valid),
        .o_result_in(16'h0000), 
        .o_result_in_valid(1'b0) 
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; // 100 MHz
    end

    // Test vectors
    reg [15:0] p_vec [7:0];
    reg [15:0] v_vec [7:0];



    integer i;



    initial begin


        // 初始化 DUT
        rst_n = 0;
        p_in = 0;
        v_in = 0;
        p_in_valid = 0;
        v_in_valid = 0;
        p_last_in = 0;

        p_vec[0] = 16'h38ce; // 1
        p_vec[1] = 16'h2cdc; // 2
        p_vec[2] = 16'h26e0; // 3
        p_vec[3] = 16'h2b4b; // 4
        p_vec[4] = 16'h2de2; // 5
        p_vec[5] = 16'h0fd0; // 6
        p_vec[6] = 16'h2cfe; // 7
        p_vec[7] = 16'h3c00; // 8

        v_vec[0] = 16'hb717; // 8
        v_vec[1] = 16'h3cdd; // 7
        v_vec[2] = 16'hb9f9; // 6
        v_vec[3] = 16'h2fad; // 5
        v_vec[4] = 16'h3a35; // 4
        v_vec[5] = 16'h34af; // 3
        v_vec[6] = 16'h3bc0; // 2
        v_vec[7] = 16'hb8db; // 1


        #100;
        rst_n = 1;
        // 输入数据
        for(i=0;i<8;i=i+1) 
        begin
            @(posedge clk);
            p_in <= p_vec[i];
            v_in <= v_vec[i];
            p_in_valid <= 1;
            v_in_valid <= 1;
            p_last_in <= (i==7) ? 1'b1 : 1'b0; 
            
        end

        // 最后几个周期关闭 valid
        @(posedge clk);
        p_in_valid <= 0;
        v_in_valid <= 0;
        p_last_in <= 0;
        // 等待 DUT 输出完成
        repeat(10) @(posedge clk);


        $finish;
    end



endmodule
