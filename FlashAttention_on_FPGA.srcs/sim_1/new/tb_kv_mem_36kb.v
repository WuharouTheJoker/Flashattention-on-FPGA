`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/27 23:58:49
// Design Name: 
// Module Name: tb_kv_mem_36kb
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
module tb_kv_mem_36kb;

    // ======================
    // 信号定义
    // ======================
    reg rst_n;

    // AXI 写端口
    reg         axi_clk;
    reg [15:0]  axi_data_in;
    reg         axi_we_in;
    reg         axi_en_in;
    reg [10:0]  axi_addr_in;

    // 控制读端口
    reg         clk;
    reg [10:0]  ctrl_addr_in;
    reg         ctrl_en_in;

    wire [10:0] ctrl_addr_out;
    wire        ctrl_en_out;
    wire [15:0] kv_data_out;
    wire        kv_data_out_valid;

    // ======================
    // DUT 实例化
    // ======================
    kv_mem_36kb dut (
        .rst_n(rst_n),

        .axi_clk(axi_clk),
        .axi_data_in(axi_data_in),
        .axi_we_in(axi_we_in),
        .axi_en_in(axi_en_in),
        .axi_addr_in(axi_addr_in),

        .clk(clk),
        .ctrl_addr_in(ctrl_addr_in),
        .ctrl_en_in(ctrl_en_in),

        .ctrl_addr_out(ctrl_addr_out),
        .ctrl_en_out(ctrl_en_out),
        .kv_data_out(kv_data_out),
        .kv_data_out_valid(kv_data_out_valid)
    );

    // ======================
    // 时钟生成
    // ======================
    always #5 axi_clk = ~axi_clk;  // 100MHz
    always #7 clk     = ~clk;      // ~71MHz（异步更真实）

    // ======================
    // 测试数据
    // ======================
    reg [15:0] golden_mem [0:31];  // 参考数据

    integer i;

    // ======================
    // 初始化
    // ======================
    initial begin
        axi_clk = 0;
        clk     = 0;

        rst_n = 0;
        axi_we_in = 0;
        axi_en_in = 0;
        axi_addr_in = 0;
        axi_data_in = 0;

        ctrl_en_in = 0;
        ctrl_addr_in = 0;

        #50;
        rst_n = 1;

        // ======================
        // 1️⃣ AXI写入
        // ======================
        @(posedge axi_clk);

        for (i = 0; i < 16; i = i + 1) begin
            @(posedge axi_clk);
            axi_en_in   <= 1;
            axi_we_in   <= 1;
            axi_addr_in <= i;
            axi_data_in <= i + 16'h100;  // 随便构造数据

            golden_mem[i] = i + 16'h100;
        end

        // 停止写
        @(posedge axi_clk);
        axi_en_in <= 0;
        axi_we_in <= 0;

        // 等待一会
        #100;

        // ======================
        // 2️⃣ 控制端读取
        // ======================
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            ctrl_en_in   <= 1;
            ctrl_addr_in <= i;
        end

        @(posedge clk);
        ctrl_en_in <= 0;

        // ======================
        // 结束仿真
        // ======================
        #200;
        $finish;
    end

    // ======================
    // 校验逻辑（重点）
    // ======================
    integer read_idx = 0;

    always @(posedge clk) begin
        if (kv_data_out_valid) begin
            if (kv_data_out !== golden_mem[read_idx]) begin
                $display("❌ ERROR at addr %0d: expect=%h, got=%h",
                          read_idx, golden_mem[read_idx], kv_data_out);
            end else begin
                $display("✅ PASS addr %0d: data=%h",
                          read_idx, kv_data_out);
            end
            read_idx = read_idx + 1;
        end
    end

endmodule
