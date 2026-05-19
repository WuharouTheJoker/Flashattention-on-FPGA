`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/05 17:50:29
// Design Name: 
// Module Name: tb_head_dim_4_top_module
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


module tb_top_module;
parameter TOKENS = 1024;  // 1024 tokens for testing, can be changed to 1024 for real use
parameter HEAD_DIM = 4; 
parameter TOTAL_TOKENS = 2048;
parameter AXI_DATA_WIDTH = 32;

localparam Q_BASE = 16'h0000;
localparam K_BASE = 16'h4000;
localparam V_BASE = 16'h8000;

localparam KV_MEM_HALF = 1024; 
localparam Q_MEM_HALF  = 512;
//======================================================
// 时钟 & 复位
//======================================================
reg clk;
reg global_rst_n;

initial clk = 0;
always #1 clk = ~clk;   // 100MHz

initial begin
    global_rst_n = 0;
    #100;
    global_rst_n = 1;
end

// AXI 时钟（先全部共用）
wire s_axi_qkv_aclk  = clk;
wire s_axi_o_aclk    = clk;
wire s_axi_ctrl_aclk = clk;
wire s_axi_intc_aclk = clk;

wire s_axi_qkv_aresetn  = global_rst_n;
wire s_axi_o_aresetn    = global_rst_n;
wire s_axi_ctrl_aresetn = global_rst_n;
wire s_axi_intc_aresetn = global_rst_n;

wire single_iter_done;
wire all_iter_done;

// ======================================================
// =============== AXI QKV（先简化：只写）===============
// ======================================================

reg  [15:0] s_axi_qkv_awaddr;
reg         s_axi_qkv_awvalid;
wire        s_axi_qkv_awready;

reg  [31:0] s_axi_qkv_wdata;
reg  [3:0]  s_axi_qkv_wstrb;
reg         s_axi_qkv_wvalid;
reg         s_axi_qkv_wlast;
wire        s_axi_qkv_wready;

wire [1:0]  s_axi_qkv_bresp;
wire        s_axi_qkv_bvalid;
reg         s_axi_qkv_bready;

// 不用的读通道直接tie-off
assign s_axi_qkv_araddr  = 0;
assign s_axi_qkv_arlen   = 0;
assign s_axi_qkv_arsize  = 0;
assign s_axi_qkv_arburst = 0;
assign s_axi_qkv_arlock  = 0;
assign s_axi_qkv_arcache = 0;
assign s_axi_qkv_arprot  = 0;
assign s_axi_qkv_arvalid = 0;
assign s_axi_qkv_rready  = 1;

// 固定burst属性（简单模式）
wire [7:0] s_axi_qkv_awlen   = 0;
wire [2:0] s_axi_qkv_awsize  = 3'b010; // 4 bytes
wire [1:0] s_axi_qkv_awburst = 2'b01;
wire       s_axi_qkv_awlock  = 0;
wire [3:0] s_axi_qkv_awcache = 0;
wire [2:0] s_axi_qkv_awprot  = 0;


// ======================================================
// ================= AXI O（只读）=======================
// ======================================================

reg  [17:0] s_axi_o_araddr;
reg         s_axi_o_arvalid;
wire        s_axi_o_arready;

wire [31:0] s_axi_o_rdata;
wire        s_axi_o_rvalid;
wire        s_axi_o_rlast;
reg         s_axi_o_rready;

// 写通道不用
assign s_axi_o_awaddr  = 0;
assign s_axi_o_awlen   = 0;
assign s_axi_o_awsize  = 0;
assign s_axi_o_awburst = 0;
assign s_axi_o_awlock  = 0;
assign s_axi_o_awcache = 0;
assign s_axi_o_awprot  = 0;
assign s_axi_o_awvalid = 0;

assign s_axi_o_wdata  = 0;
assign s_axi_o_wstrb  = 0;
assign s_axi_o_wlast  = 0;
assign s_axi_o_wvalid = 0;

assign s_axi_o_bready = 1;

// read burst 固定
reg [7:0] s_axi_o_arlen   = 0;
reg [2:0] s_axi_o_arsize  = 3'b010;
reg [1:0] s_axi_o_arburst = 2'b01;
reg       s_axi_o_arlock  = 0;
reg [3:0] s_axi_o_arcache = 0;
reg [2:0] s_axi_o_arprot  = 0;


// ======================================================
// ================= AXI CTRL ===========================
// ======================================================

reg  [3:0]  s_axi_ctrl_awaddr;
reg         s_axi_ctrl_awvalid;
wire        s_axi_ctrl_awready;

reg  [31:0] s_axi_ctrl_wdata;
reg  [3:0]  s_axi_ctrl_wstrb;
reg         s_axi_ctrl_wvalid;
wire        s_axi_ctrl_wready;

wire [1:0]  s_axi_ctrl_bresp;
wire        s_axi_ctrl_bvalid;
reg         s_axi_ctrl_bready;

reg  [3:0]  s_axi_ctrl_araddr;
reg         s_axi_ctrl_arvalid;
wire        s_axi_ctrl_arready;

wire [31:0] s_axi_ctrl_rdata;
wire        s_axi_ctrl_rvalid;
reg         s_axi_ctrl_rready;

wire [2:0] s_axi_ctrl_awprot = 0;
wire [2:0] s_axi_ctrl_arprot = 0;


// ======================================================
// ================= AXI INTC（先不用）===================
// ======================================================

assign s_axi_intc_awaddr  = 0;
assign s_axi_intc_awvalid = 0;
assign s_axi_intc_wdata   = 0;
assign s_axi_intc_wstrb   = 0;
assign s_axi_intc_wvalid  = 0;
assign s_axi_intc_bready  = 1;
assign s_axi_intc_araddr  = 0;
assign s_axi_intc_arvalid = 0;
assign s_axi_intc_rready  = 1;

wire irq;
// ==============load mem====================
reg [15:0] Q_mem [0:TOTAL_TOKENS*HEAD_DIM-1];
reg [15:0] K_mem [0:TOTAL_TOKENS*HEAD_DIM-1];
reg [15:0] V_mem [0:TOTAL_TOKENS*HEAD_DIM-1];

initial begin
    $display("Loading memory...");

    // $readmemh("Q64x4.mem", Q_mem);
    // $readmemh("K64x4.mem", K_mem);
    // $readmemh("V64x4.mem", V_mem);
    $readmemh("Q2048x4.mem", Q_mem);
    $readmemh("K2048x4.mem", K_mem);
    $readmemh("V2048x4.mem", V_mem);

    $display("Memory loaded.");
end

integer O_normalized_axi_fout;

initial 
begin
    O_normalized_axi_fout = $fopen("O_normalized_axi_output.mem","w");
end

integer o_num = 0;
reg [15:0] O_mem [0:TOTAL_TOKENS*HEAD_DIM-1];

integer base;
integer offset;

always @(posedge s_axi_o_aclk) begin
    if (!s_axi_o_aresetn) begin
        o_num <= 0;
    end
    else if (s_axi_o_rvalid && s_axi_o_rready) begin

        base   = (o_num / HEAD_DIM) * (2 * HEAD_DIM);
        offset = o_num % HEAD_DIM;

        // 低16bit → 前半段
        O_mem[base + offset] <= s_axi_o_rdata[15:0];

        // 高16bit → 后半段
        O_mem[base + offset + HEAD_DIM] <= s_axi_o_rdata[31:16];

        o_num <= o_num + 1;
    end
end
// ======================================================
// ================= DUT ================================
// ======================================================

head_dim_4_top_module #(
    .TOKENS(TOKENS)
) dut (

    // QKV AXI
    .s_axi_qkv_aclk(s_axi_qkv_aclk),
    .s_axi_qkv_aresetn(s_axi_qkv_aresetn),
    .s_axi_qkv_awaddr(s_axi_qkv_awaddr),
    .s_axi_qkv_awlen(s_axi_qkv_awlen),
    .s_axi_qkv_awsize(s_axi_qkv_awsize),
    .s_axi_qkv_awburst(s_axi_qkv_awburst),
    .s_axi_qkv_awlock(s_axi_qkv_awlock),
    .s_axi_qkv_awcache(s_axi_qkv_awcache),
    .s_axi_qkv_awprot(s_axi_qkv_awprot),
    .s_axi_qkv_awvalid(s_axi_qkv_awvalid),
    .s_axi_qkv_awready(s_axi_qkv_awready),

    .s_axi_qkv_wdata(s_axi_qkv_wdata),
    .s_axi_qkv_wstrb(s_axi_qkv_wstrb),
    .s_axi_qkv_wlast(s_axi_qkv_wlast),
    .s_axi_qkv_wvalid(s_axi_qkv_wvalid),
    .s_axi_qkv_wready(s_axi_qkv_wready),

    .s_axi_qkv_bresp(s_axi_qkv_bresp),
    .s_axi_qkv_bvalid(s_axi_qkv_bvalid),
    .s_axi_qkv_bready(s_axi_qkv_bready),

    .s_axi_qkv_araddr(0),
    .s_axi_qkv_arlen(0),
    .s_axi_qkv_arsize(0),
    .s_axi_qkv_arburst(0),
    .s_axi_qkv_arlock(0),
    .s_axi_qkv_arcache(0),
    .s_axi_qkv_arprot(0),
    .s_axi_qkv_arvalid(0),
    .s_axi_qkv_arready(),

    .s_axi_qkv_rdata(),
    .s_axi_qkv_rresp(),
    .s_axi_qkv_rlast(),
    .s_axi_qkv_rvalid(),
    .s_axi_qkv_rready(1),

    // O AXI
    .s_axi_o_aclk(s_axi_o_aclk),
    .s_axi_o_aresetn(s_axi_o_aresetn),

    .s_axi_o_awaddr(s_axi_o_awaddr),
    .s_axi_o_awlen(s_axi_o_awlen),
    .s_axi_o_awsize(s_axi_o_awsize),
    .s_axi_o_awburst(s_axi_o_awburst),
    .s_axi_o_awlock(s_axi_o_awlock),
    .s_axi_o_awcache(s_axi_o_awcache),
    .s_axi_o_awprot(s_axi_o_awprot),
    .s_axi_o_awvalid(s_axi_o_awvalid),
    .s_axi_o_awready(s_axi_o_awready),

    .s_axi_o_wdata(s_axi_o_wdata),
    .s_axi_o_wstrb(s_axi_o_wstrb),
    .s_axi_o_wlast(s_axi_o_wlast),
    .s_axi_o_wvalid(s_axi_o_wvalid),
    .s_axi_o_wready(s_axi_o_wready),

    .s_axi_o_bresp(s_axi_o_bresp),
    .s_axi_o_bvalid(s_axi_o_bvalid),
    .s_axi_o_bready(s_axi_o_bready),

    .s_axi_o_araddr(s_axi_o_araddr),
    .s_axi_o_arlen(s_axi_o_arlen),
    .s_axi_o_arsize(s_axi_o_arsize),
    .s_axi_o_arburst(s_axi_o_arburst),
    .s_axi_o_arlock(s_axi_o_arlock),
    .s_axi_o_arcache(s_axi_o_arcache),
    .s_axi_o_arprot(s_axi_o_arprot),
    .s_axi_o_arvalid(s_axi_o_arvalid),
    .s_axi_o_arready(s_axi_o_arready),

    .s_axi_o_rdata(s_axi_o_rdata),
    .s_axi_o_rresp(s_axi_o_rresp),
    .s_axi_o_rlast(s_axi_o_rlast),
    .s_axi_o_rvalid(s_axi_o_rvalid),
    .s_axi_o_rready(s_axi_o_rready),

    // ctrl
    .s_axi_ctrl_aclk(s_axi_ctrl_aclk),
    .s_axi_ctrl_aresetn(s_axi_ctrl_aresetn),
    .s_axi_ctrl_awaddr(s_axi_ctrl_awaddr),
    .s_axi_ctrl_awprot(0),
    .s_axi_ctrl_awvalid(s_axi_ctrl_awvalid),
    .s_axi_ctrl_awready(s_axi_ctrl_awready),
    .s_axi_ctrl_wdata(s_axi_ctrl_wdata),
    .s_axi_ctrl_wstrb(s_axi_ctrl_wstrb),
    .s_axi_ctrl_wvalid(s_axi_ctrl_wvalid),
    .s_axi_ctrl_wready(s_axi_ctrl_wready),
    .s_axi_ctrl_bresp(s_axi_ctrl_bresp),
    .s_axi_ctrl_bvalid(s_axi_ctrl_bvalid),
    .s_axi_ctrl_bready(s_axi_ctrl_bready),
    .s_axi_ctrl_araddr(s_axi_ctrl_araddr),
    .s_axi_ctrl_arprot(0),
    .s_axi_ctrl_arvalid(s_axi_ctrl_arvalid),
    .s_axi_ctrl_arready(s_axi_ctrl_arready),
    .s_axi_ctrl_rdata(s_axi_ctrl_rdata),
    .s_axi_ctrl_rresp(),
    .s_axi_ctrl_rvalid(s_axi_ctrl_rvalid),
    .s_axi_ctrl_rready(s_axi_ctrl_rready),

    // intc
    .s_axi_intc_aclk(s_axi_intc_aclk),
    .s_axi_intc_aresetn(s_axi_intc_aresetn),
    .s_axi_intc_awaddr(0),
    .s_axi_intc_awvalid(0),
    .s_axi_intc_awready(),
    .s_axi_intc_wdata(0),
    .s_axi_intc_wstrb(0),
    .s_axi_intc_wvalid(0),
    .s_axi_intc_wready(),
    .s_axi_intc_bresp(),
    .s_axi_intc_bvalid(),
    .s_axi_intc_bready(1),
    .s_axi_intc_araddr(0),
    .s_axi_intc_arvalid(0),
    .s_axi_intc_arready(),
    .s_axi_intc_rdata(),
    .s_axi_intc_rresp(),
    .s_axi_intc_rvalid(),
    .s_axi_intc_rready(1),

    .irq(irq),

    .clk(clk),
    .single_iter_done(single_iter_done),
    .all_iter_done(all_iter_done)
);

task axi_write_32;
    input [15:0] addr;
    input [31:0] data;
begin
    @(posedge s_axi_qkv_aclk);

    // AW
    s_axi_qkv_awaddr  <= addr;
    s_axi_qkv_awvalid <= 1;

    wait(s_axi_qkv_awready);
    @(posedge s_axi_qkv_aclk);
    s_axi_qkv_awvalid <= 0;

    // W
    s_axi_qkv_wdata  <= data;
    s_axi_qkv_wstrb  <= 4'b1111;
    s_axi_qkv_wvalid <= 1;
    s_axi_qkv_wlast  <= 1;

    wait(s_axi_qkv_wready);
    @(posedge s_axi_qkv_aclk);
    s_axi_qkv_wvalid <= 0;

    // B
    s_axi_qkv_bready <= 1;
    wait(s_axi_qkv_bvalid);
    @(posedge s_axi_qkv_aclk);
    s_axi_qkv_bready <= 0;
end
endtask

task write_QKV_axi;
    input integer batch_id;
    input integer pingpong_mode;

    integer token, dim;
    integer base_offset;

    reg [31:0] packed_q;
    reg [31:0] packed_k;
    reg [31:0] packed_v;

    integer q_addr, k_addr, v_addr;

begin
    base_offset = batch_id * TOKENS;

    for(token = 0; token < TOKENS; token = token + 1) begin
        for(dim = 0; dim < HEAD_DIM; dim = dim + 2) begin

            // =========================
            // 打包 (两个FP16 → 32bit)
            // =========================
            packed_q = {
                Q_mem[(base_offset+token)*HEAD_DIM + dim + 1],
                Q_mem[(base_offset+token)*HEAD_DIM + dim]
            };

            packed_k = {
                K_mem[(base_offset+token)*HEAD_DIM + dim + 1],
                K_mem[(base_offset+token)*HEAD_DIM + dim]
            };

            packed_v = {
                V_mem[(base_offset+token)*HEAD_DIM + dim + 1],
                V_mem[(base_offset+token)*HEAD_DIM + dim]
            };

            // =========================
            // 地址计算（核心！！）
            // =========================

            // Q（有pingpong）
            q_addr = Q_BASE 
                   + (pingpong_mode ? Q_MEM_HALF : 0)*HEAD_DIM*4
                   + ((token*HEAD_DIM + dim) * 2);

            // K（有pingpong）
            k_addr = K_BASE 
                   + (pingpong_mode ? KV_MEM_HALF : 0)*HEAD_DIM*2
                   + ((token*HEAD_DIM + dim) * 2);

            // V（有pingpong）
            v_addr = V_BASE 
                   + (pingpong_mode ? KV_MEM_HALF : 0)*HEAD_DIM*2
                   + ((token*HEAD_DIM + dim) * 2);

            // =========================
            // 顺序写入（左上→右下）
            // =========================
            axi_write_32(q_addr, packed_q);
            axi_write_32(k_addr, packed_k);
            axi_write_32(v_addr, packed_v);

        end
    end
end
endtask

task axi_lite_write_ctrl;
    input [3:0]  addr;
    input [31:0] data;
begin
    @(posedge s_axi_ctrl_aclk);

    // 地址 + 数据 同时给
    s_axi_ctrl_awaddr  <= addr;
    s_axi_ctrl_awvalid <= 1;

    s_axi_ctrl_wdata  <= data;
    s_axi_ctrl_wstrb  <= 4'b1111;
    s_axi_ctrl_wvalid <= 1;

    // 等待握手
    wait(s_axi_ctrl_awready && s_axi_ctrl_wready);

    @(posedge s_axi_ctrl_aclk);

    s_axi_ctrl_awvalid <= 0;
    s_axi_ctrl_wvalid  <= 0;

    // 写响应
    s_axi_ctrl_bready <= 1;
    wait(s_axi_ctrl_bvalid);

    @(posedge s_axi_ctrl_aclk);
    s_axi_ctrl_bready <= 0;
end
endtask

task start_flashattention;
    input        rst_n_val;
    input        qk_mem_en_val;
    input [7:0]  iter_num_val;
    input        iter_num_valid_val;

    reg [31:0] ctrl_reg;
begin
    // =========================
    // 1️⃣ 写 iter_num 寄存器
    // =========================
    axi_lite_write_ctrl(4'h4, {23'd0,iter_num_valid_val,iter_num_val});

    // =========================
    // 2️⃣ 组 ctrl 寄存器
    // =========================
    ctrl_reg = 32'd0;

    ctrl_reg[0] = rst_n_val;
    ctrl_reg[1] = qk_mem_en_val;

    axi_lite_write_ctrl(4'h0, ctrl_reg);
end
endtask

task read_o_result;
    input integer total_words;   // = HEAD_DIM * TOKENS

    integer i;
begin
    $display("\n========== START READ O ==========");

    for (i = 0; i < TOKENS*HEAD_DIM/2; i = i + 1) begin

        @(posedge s_axi_o_aclk);

        // =========================
        // 1️⃣ 发 AR（单次读）
        // =========================
        s_axi_o_araddr  <= (i << 2);   // word → byte 地址
        s_axi_o_arlen   <= 0;          // single beat
        s_axi_o_arsize  <= 3'd2;       // 4 bytes
        s_axi_o_arburst <= 2'b01;
        s_axi_o_arvalid <= 1;

        wait(s_axi_o_arready);
        @(posedge s_axi_o_aclk);
        s_axi_o_arvalid <= 0;

        // =========================
        // 2️⃣ 收 R
        // =========================
        s_axi_o_rready <= 1;

        wait(s_axi_o_rvalid);
        @(posedge s_axi_o_aclk);

        $display("[O] idx=%0d addr=0x%08h data=0x%08h",
                 i, (i<<2), s_axi_o_rdata);

        s_axi_o_rready <= 0;

    end

    $display("========== END READ O ==========\n");

end
endtask

initial begin
    // O AXI init（必须！）
    s_axi_o_araddr  = 0;
    s_axi_o_arvalid = 0;
    s_axi_o_rready  = 0;

    s_axi_o_arlen   = 0;
    s_axi_o_arsize  = 3'b010;
    s_axi_o_arburst = 2'b01;
    s_axi_o_arlock  = 0;
    s_axi_o_arcache = 0;
    s_axi_o_arprot  = 0;
end

initial begin

    // 等待复位结束
    wait(global_rst_n);

    // 写入第一批数据（pingpong模式0）
    write_QKV_axi(0, 0);

    // 写入第二批数据（pingpong模式1）
    write_QKV_axi(1, 1);

    // 启动计算
    start_flashattention(1, 1, TOTAL_TOKENS/TOKENS, 1); // rst_n=1, qk_mem_en=1, iter_num=8, iter_num_valid=1
    start_flashattention(1, 1, TOTAL_TOKENS/TOKENS, 0); // rst_n=1, qk_mem_en=1, iter_num=8, iter_num_valid=1

    wait(all_iter_done); // 等待所有迭代完成

    read_o_result(TOKENS * HEAD_DIM);


    wait(all_iter_done); // 等待所有迭代完成

    read_o_result(TOKENS * HEAD_DIM);
    
    start_flashattention(0, 0, 0, 0); 

    for(integer i = 0; i < TOTAL_TOKENS*HEAD_DIM; i = i + 1) 
    begin
        $fdisplay(O_normalized_axi_fout, "%h", O_mem[i]);
    end
    
    #100; // 等待足够的时间让DUT处理数据
    $fflush(O_normalized_axi_fout);
    $stop;
end

endmodule
