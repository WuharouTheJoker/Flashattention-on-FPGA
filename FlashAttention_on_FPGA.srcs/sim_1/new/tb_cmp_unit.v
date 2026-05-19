`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/17 17:24:16
// Design Name: 
// Module Name: tb_cmp_unit
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

module tb_cmp_unit;

    reg clk;
    reg rst_n;

    reg         s_valid_in;
    reg [15:0]  s_in;
    reg         s_last_in;

    wire        s_valid_out;
    wire [15:0] s_out;
    wire        s_last_out;
    wire [15:0] cmp_m_out;
    wire        m_valid_out;

    // ================================
    // DUT
    // ================================
    cmp_unit dut (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid_in(s_valid_in),
        .s_in(s_in),
        .s_last_in(s_last_in),

        .s_valid_out(s_valid_out),
        .s_out(s_out),
        .s_last_out(s_last_out),

        .cmp_m_out(cmp_m_out),
        .m_valid_out(m_valid_out)
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
        #10;
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
        repeat(10) @(posedge clk);

        $finish;
    end

    // ================================
    // 打印输出
    // ================================
    always @(posedge clk) begin
        if (s_valid_in) begin
            $display("TIME=%0t | IN=%h | MAX=%h | LAST=%b",
                     $time, s_in, cmp_m_out, s_last_in);
        end
    end

endmodule