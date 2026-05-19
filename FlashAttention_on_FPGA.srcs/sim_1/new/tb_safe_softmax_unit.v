`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/19 00:16:50
// Design Name: 
// Module Name: tb_safe_softmax_unit
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


module tb_safe_softmax_unit;

    reg clk;
    reg rst_n;

    reg [15:0] s_in;
    reg s_valid_in;
    reg s_last_in;  

    wire p_valid_out;
    wire [15:0] p_out;
    wire p_last_out;

    wire r_valid_out;
    wire [15:0] r_out;
    
    wire m_valid_out;
    wire [15:0] m_out;

    safe_softmax_unit uut (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid_in(s_valid_in),
        .s_in(s_in),
        .s_last_in(s_last_in),

        .p_valid_out(p_valid_out),
        .p_last_out(p_last_out),
        .p_out(p_out),

        .r_valid_out(r_valid_out),
        .r_out(r_out),

        .m_valid_out(m_valid_out),
        .m_out(m_out)
        );

    // ================================
    // 时钟
    // ================================
    always #5 clk = ~clk;  // 100MHz

    // ================================
    // FP16 测试数据（直接用hex）
    // ================================
    reg [15:0] test_data [0:7];

    integer i;

    initial begin
        // 初始化
        clk = 1;
        rst_n = 0;
        s_valid_in = 0;
        s_in = 0;
        s_last_in = 0;

        // 一些 FP16 数值（大致递增/乱序）
        test_data[0] = 16'h3C00; // 1.0
        test_data[1] = 16'h4000; // 2.0
        test_data[2] = 16'h3800; // 0.5
        test_data[3] = 16'h4200; // 3.0
        test_data[7] = 16'h4600; // 6.0
        test_data[5] = 16'h4400; // 4.0
        test_data[6] = 16'h3A00; // 0.75
        test_data[4] = 16'h3E00; // 1.5

        // 复位
        #100;
        rst_n = 1;
        // ================================
        // 输入数据流
        // ================================
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            s_valid_in <= 1;
            s_in <= test_data[i % 8];
            s_last_in <= ((i+1)%8 == 0);
        end

        // 停止输入
        @(posedge clk);
        s_valid_in <= 0;
        s_in <= 0;
        s_last_in <= 0;

        // 再跑几拍观察结果
        repeat(1000) @(posedge clk);

        $finish;
    end


endmodule
