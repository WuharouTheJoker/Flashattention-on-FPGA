`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/09 02:24:44
// Design Name: 
// Module Name: tb_flashattention2_iter_unit
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
`timescale 1ns / 1ps

module tb_flashattention2_iter_unit;

parameter Q_TOKENS = 8;
parameter HEAD_DIM = 4;
parameter TOTAL_O = Q_TOKENS * HEAD_DIM;

// ======================
// DUT 信号
// ======================
reg clk;
reg rst_n;

reg [7:0] iter_num_in;
reg iter_num_valid_in;

reg [15:0] local_m_data_in;
reg local_m_data_valid_in;

reg [15:0] local_r_data_in;
reg local_r_data_valid_in;

reg [15:0] local_o_data_in;
reg local_o_data_valid_in;

wire single_iter_done_out;
wire all_iter_done_out;

reg o_result_read_en_in;
reg [15:0] o_result_read_addr_in;
wire [15:0] o_result_read_data_out;
wire o_result_read_valid_out;

// ======================
// 实例化 DUT
// ======================
flashattention2_iter_unit #(
    .Q_TOKENS(Q_TOKENS),
    .HEAD_DIM(HEAD_DIM)
) dut (
    .clk(clk),
    .rst_n(rst_n),

    .iter_num_in(iter_num_in),
    .iter_num_valid_in(iter_num_valid_in),

    .local_m_data_in(local_m_data_in),
    .local_m_data_valid_in(local_m_data_valid_in),

    .local_r_data_in(local_r_data_in),
    .local_r_data_valid_in(local_r_data_valid_in),

    .local_o_data_in(local_o_data_in),
    .local_o_data_valid_in(local_o_data_valid_in),

    .bram_to_axi_clk(clk),
    .o_result_read_en_in(o_result_read_en_in),
    .o_result_read_addr_in(o_result_read_addr_in),
    .o_result_read_data_out(o_result_read_data_out),
    .o_result_read_valid_out(o_result_read_valid_out),

    .single_iter_done_out(single_iter_done_out),
    .all_iter_done_out(all_iter_done_out)
);

// ======================
// 时钟
// ======================
initial clk = 0;
always #1 clk = ~clk;

// ======================
// mem
// ======================
reg [15:0] m1_mem [0:Q_TOKENS-1];
reg [15:0] r1_mem [0:Q_TOKENS-1];
reg [15:0] o1_mem [0:TOTAL_O-1];

reg [15:0] m2_mem [0:Q_TOKENS-1];
reg [15:0] r2_mem [0:Q_TOKENS-1];
reg [15:0] o2_mem [0:TOTAL_O-1];

// ======================
// 初始化
// ======================
integer i;

initial begin
    rst_n = 0;

    local_m_data_valid_in = 0;
    local_r_data_valid_in = 0;
    local_o_data_valid_in = 0;

    iter_num_in = 2;
    iter_num_valid_in = 0;

    // ======== 读取文件（关键）========
    $readmemh("q0_kv0_m.mem", m1_mem);
    $readmemh("q0_kv0_R.mem", r1_mem);
    $readmemh("q0_kv0_O.mem", o1_mem);

    $readmemh("q0_kv1_m.mem", m2_mem);
    $readmemh("q0_kv1_R.mem", r2_mem);
    $readmemh("q0_kv1_O.mem", o2_mem);

    // ======================
    // 复位释放
    // ======================
    #20;
    rst_n = 1;

    // 送 iter_num
    @(posedge clk);
    iter_num_valid_in = 1;
    @(posedge clk);
    iter_num_valid_in = 0;

    // =====================================================
    // 第1轮：q0_kv0
    // =====================================================

    // ---- m ----
    for(i = 0; i < Q_TOKENS; i = i + 1) begin
        @(posedge clk);
        local_m_data_in <= m1_mem[i];
        local_m_data_valid_in <= 1;
    end
    @(posedge clk);
    local_m_data_valid_in <= 0;
    #20;
    // ---- r ----
    for(i = 0; i < Q_TOKENS; i = i + 1) begin
        @(posedge clk);
        local_r_data_in <= r1_mem[i];
        local_r_data_valid_in <= 1;
    end
    @(posedge clk);
    local_r_data_valid_in <= 0;

    // ---- o ----
    for(i = 0; i < TOTAL_O; i = i + 1) begin
        @(posedge clk);
        local_o_data_in <= o1_mem[i];
        local_o_data_valid_in <= 1;
    end
    @(posedge clk);
    local_o_data_valid_in <= 0;

    // // 等待一轮结束（推荐）
    // wait(single_iter_done_out);

    // =====================================================
    // 第2轮：q0_kv1
    // =====================================================

    // ---- m ----
    for(i = 0; i < Q_TOKENS; i = i + 1) begin
        @(posedge clk);
        local_m_data_in <= m2_mem[i];
        local_m_data_valid_in <= 1;
    end
    @(posedge clk);
    local_m_data_valid_in <= 0;
    #20;
    // ---- r ----
    for(i = 0; i < Q_TOKENS; i = i + 1) begin
        @(posedge clk);
        local_r_data_in <= r2_mem[i];
        local_r_data_valid_in <= 1;
    end
    @(posedge clk);
    local_r_data_valid_in <= 0;

    // ---- o ----
    for(i = 0; i < TOTAL_O; i = i + 1) begin
        @(posedge clk);
        local_o_data_in <= o2_mem[i];
        local_o_data_valid_in <= 1;
    end
    @(posedge clk);
    local_o_data_valid_in <= 0;

    // ======================
    // 等待全部结束
    // ======================
    wait(all_iter_done_out);

    for(i = 0; i < TOTAL_O; i = i + 1) begin
        @(posedge clk);
        o_result_read_addr_in <= i;
        o_result_read_en_in <= 1;
        
    end
    
    @(posedge clk);
    o_result_read_en_in <= 0;

    #20;
    $finish;

end

endmodule