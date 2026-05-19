`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/28 23:20:17
// Design Name: 
// Module Name: tb_iter_unit
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

module tb_iter_unit;

parameter Q_TOKENS = 8;
parameter HEAD_DIM = 4;

reg clk;
reg axi_clk;
reg rst_n;

// AXI old write
reg [15:0] axi_old_o_data_in;
reg axi_old_o_we_in;
reg axi_old_o_en_in;
reg [16:0] axi_old_o_addr_in;

reg [15:0] axi_old_m_data_in;
reg axi_old_m_we_in;
reg axi_old_m_en_in;
reg [9:0] axi_old_m_addr_in;

reg [15:0] axi_old_r_data_in;
reg axi_old_r_we_in;
reg axi_old_r_en_in;
reg [9:0] axi_old_r_addr_in;

// local inputs
reg [15:0] local_m_data_in;
reg local_m_data_valid_in;

reg [15:0] local_r_data_in;
reg local_r_data_valid_in;

reg [15:0] local_o_data_in;
reg local_o_data_valid_in;

// AXI new read
reg axi_new_o_en_in;
reg [16:0] axi_new_o_addr_in;
wire [15:0] axi_new_o_data_out;
wire axi_new_o_valid_out;

reg axi_new_m_en_in;
reg [9:0] axi_new_m_addr_in;
wire [15:0] axi_new_m_data_out;
wire axi_new_m_valid_out;

reg axi_new_r_en_in;
reg [9:0] axi_new_r_addr_in;
wire [15:0] axi_new_r_data_out;
wire axi_new_r_valid_out;

wire iter_unit_done_out;

// DUT
iter_unit #(
    .Q_TOKENS(Q_TOKENS),
    .HEAD_DIM(HEAD_DIM)
) dut (
    .rst_n(rst_n),
    .clk(clk),
    .axi_clk(axi_clk),

    // old_o
    .axi_old_o_data_in(axi_old_o_data_in),
    .axi_old_o_we_in(axi_old_o_we_in),
    .axi_old_o_en_in(axi_old_o_en_in),
    .axi_old_o_addr_in(axi_old_o_addr_in),

    // old_m
    .axi_old_m_data_in(axi_old_m_data_in),
    .axi_old_m_we_in(axi_old_m_we_in),
    .axi_old_m_en_in(axi_old_m_en_in),
    .axi_old_m_addr_in(axi_old_m_addr_in),

    // old_r
    .axi_old_r_data_in(axi_old_r_data_in),
    .axi_old_r_we_in(axi_old_r_we_in),
    .axi_old_r_en_in(axi_old_r_en_in),
    .axi_old_r_addr_in(axi_old_r_addr_in),

    // local m/r/o
    .local_m_data_in(local_m_data_in),
    .local_m_data_valid_in(local_m_data_valid_in),

    .local_r_data_in(local_r_data_in),
    .local_r_data_valid_in(local_r_data_valid_in),

    .local_o_data_in(local_o_data_in),
    .local_o_data_valid_in(local_o_data_valid_in),

    // new_o
    .axi_new_o_en_in(axi_new_o_en_in),
    .axi_new_o_addr_in(axi_new_o_addr_in),
    .axi_new_o_data_out(axi_new_o_data_out),
    .axi_new_o_valid_out(axi_new_o_valid_out),

    // new_m
    .axi_new_m_en_in(axi_new_m_en_in),
    .axi_new_m_addr_in(axi_new_m_addr_in),
    .axi_new_m_data_out(axi_new_m_data_out),
    .axi_new_m_valid_out(axi_new_m_valid_out),

    // new_r
    .axi_new_r_en_in(axi_new_r_en_in),
    .axi_new_r_addr_in(axi_new_r_addr_in),
    .axi_new_r_data_out(axi_new_r_data_out),
    .axi_new_r_valid_out(axi_new_r_valid_out),

    .iter_unit_done_out(iter_unit_done_out)      
);




// =======================
// 时钟
// =======================
initial clk = 0;
always #1 clk = ~clk;     

initial axi_clk = 0;
always #1 axi_clk = ~axi_clk; 


// =======================
// MEM 定义
// =======================

reg [15:0] local_m_mem [0:Q_TOKENS-1];
reg [15:0] local_r_mem [0:Q_TOKENS-1];
reg [15:0] local_o_mem [0:Q_TOKENS*HEAD_DIM-1];

reg [15:0] old_m_mem [0:Q_TOKENS-1];
reg [15:0] old_r_mem [0:Q_TOKENS-1];
reg [15:0] old_o_mem [0:Q_TOKENS*HEAD_DIM-1];


// =======================
// 初始化
// =======================
initial begin
    $readmemh("m.mem", local_m_mem);
    $readmemh("R.mem", local_r_mem);
    $readmemh("O.mem", local_o_mem);

    $readmemh("old_m.mem", old_m_mem);
    $readmemh("old_R.mem", old_r_mem);
    $readmemh("old_O.mem", old_o_mem);
end


// =======================
// Reset
// =======================
initial begin
    rst_n = 0;
    pingpang_mode = 0;

    axi_old_o_en_in = 0;
    axi_old_o_we_in = 0;
    axi_old_m_en_in = 0;
    axi_old_m_we_in = 0;
    axi_old_r_en_in = 0;
    axi_old_r_we_in = 0;

    local_m_data_valid_in = 0;
    local_r_data_valid_in = 0;
    local_o_data_valid_in = 0;

    #100;
    rst_n = 1;
end


// ======================================================
// 1️⃣ 先写 OLD 数据（AXI 写 BRAM）
// ======================================================
task write_old_mem;
    integer i;
    begin
        @(posedge axi_clk);

        // old_m
        for(i=0;i<Q_TOKENS;i=i+1) begin
            axi_old_m_en_in <= 1;
            axi_old_m_we_in <= 1;
            axi_old_m_addr_in <= i;
            axi_old_m_data_in <= old_m_mem[i];
            @(posedge axi_clk);
        end
        axi_old_m_en_in <= 0;
        axi_old_m_we_in <= 0;

        // old_r
        for(i=0;i<Q_TOKENS;i=i+1) begin
            axi_old_r_en_in <= 1;
            axi_old_r_we_in <= 1;
            axi_old_r_addr_in <= i;
            axi_old_r_data_in <= old_r_mem[i];
            @(posedge axi_clk);
        end
        axi_old_r_en_in <= 0;
        axi_old_r_we_in <= 0;

        // old_o
        for(i=0;i<Q_TOKENS*HEAD_DIM;i=i+1) begin
            axi_old_o_en_in <= 1;
            axi_old_o_we_in <= 1;
            axi_old_o_addr_in <= i;
            axi_old_o_data_in <= old_o_mem[i];
            @(posedge axi_clk);
        end
        axi_old_o_en_in <= 0;
        axi_old_o_we_in <= 0;
    end
endtask


// ======================================================
// 2️⃣ 写 LOCAL m / r
// ======================================================
task write_local_m_r;
    integer i;
    begin
        // local_m
        for(i=0;i<Q_TOKENS;i=i+1) begin
            @(posedge clk);
            local_m_data_valid_in <= 1;
            local_m_data_in <= local_m_mem[i];
        end
        @(posedge clk);
        local_m_data_valid_in <= 0;

        // local_r
        for(i=0;i<Q_TOKENS;i=i+1) begin
            @(posedge clk);
            local_r_data_valid_in <= 1;
            local_r_data_in <= local_r_mem[i];
        end
        @(posedge clk);
        local_r_data_valid_in <= 0;
    end
endtask


// ======================================================
// 3️⃣ 最后 streaming 输入 local_o
// ======================================================
task stream_local_o;
    integer i;
    begin
        for(i=0;i<Q_TOKENS*HEAD_DIM;i=i+1) begin
            @(posedge clk);
            local_o_data_valid_in <= 1;
            local_o_data_in <= local_o_mem[i];
        end
        @(posedge clk);
        local_o_data_valid_in <= 0;
    end
endtask

task read_new_m;
    integer i;
    begin
        $display("==== READ NEW M ====");

        for(i=0;i<Q_TOKENS;i=i+1) begin
            @(posedge axi_clk);
            axi_new_m_en_in   <= 1;
            axi_new_m_addr_in <= {pingpang_mode, i};
        end
        @(posedge axi_clk);
        axi_new_m_en_in <= 0;
    end
endtask

task read_new_r;
    integer i;
    begin
        $display("==== READ NEW R ====");

        for(i=0;i<Q_TOKENS;i=i+1) begin
            @(posedge axi_clk);
            axi_new_r_en_in   <= 1;
            axi_new_r_addr_in <= {pingpang_mode, i};

        end
        @(posedge axi_clk);
        axi_new_r_en_in <= 0;
    end
endtask

task read_new_o;
    integer i;
    begin
        $display("==== READ NEW O ====");

        for(i=0;i<Q_TOKENS*HEAD_DIM;i=i+1) begin
            @(posedge axi_clk);
            axi_new_o_en_in   <= 1;
            axi_new_o_addr_in <= {pingpang_mode, i};
        end
        @(posedge axi_clk);
        axi_new_o_en_in <= 0;
    end
endtask

// ======================================================
// 主流程
// ======================================================
initial begin
    wait(rst_n);

    // 1. 写 old
    write_old_mem();

    // 2. 写 local m / r
    write_local_m_r();

    // 3. 流式输入 local_o
    stream_local_o();

    wait(iter_unit_done_out);

    read_new_m();
    read_new_r();
    read_new_o();

    #100
    $stop;
end

endmodule
