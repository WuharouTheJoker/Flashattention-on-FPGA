`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/01 00:20:37
// Design Name: 
// Module Name: tb_real_flashattention_with_bram_unit
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


module tb_real_flashattention_with_bram_unit;

parameter TOKENS   = 8;
parameter HEAD_DIM = 4;
parameter Q_TILES  = 2;
parameter inv_sqrt_head_dim = 16'h3800;

// ======================================================
// 时钟 & Reset
// ======================================================
reg clk;
reg axi_clk;
reg rst_n;

initial clk = 1;
always #1 clk = ~clk;

initial axi_clk = 1;
always #1 axi_clk = ~axi_clk;


// ======================================================
// DUT接口信号
// ======================================================

// ---------- K ----------
reg  [HEAD_DIM*16-1:0] axi_k_data_in_bus;
reg  [HEAD_DIM-1:0]    axi_k_we_in_bus;
reg  [HEAD_DIM-1:0]    axi_k_en_in_bus;
reg  [HEAD_DIM*11-1:0] axi_k_addr_in_bus;

// ---------- Q ----------
reg  [Q_TILES*HEAD_DIM*16-1:0] axi_q_data_in_bus;
reg  [Q_TILES*HEAD_DIM-1:0]    axi_q_we_in_bus;
reg  [Q_TILES*HEAD_DIM-1:0]    axi_q_en_in_bus;
reg  [Q_TILES*HEAD_DIM*10-1:0] axi_q_addr_in_bus;

// ---------- V ----------
reg  [HEAD_DIM*16-1:0] axi_v_data_in_bus;
reg  [HEAD_DIM-1:0]    axi_v_we_in_bus;
reg  [HEAD_DIM-1:0]    axi_v_en_in_bus;
reg  [HEAD_DIM*11-1:0] axi_v_addr_in_bus;

// ===== old_m =====
reg [Q_TILES*16-1:0] axi_old_m_data_in_bus;
reg [Q_TILES-1:0]       axi_old_m_we_bus;
reg [Q_TILES-1:0]       axi_old_m_en_bus;
reg [Q_TILES*10-1:0]  axi_old_m_addr_bus;

// ===== old_r =====
reg [Q_TILES*16-1:0] axi_old_r_data_in_bus;
reg [Q_TILES-1:0]       axi_old_r_we_bus;
reg [Q_TILES-1:0]       axi_old_r_en_bus;
reg [Q_TILES*10-1:0]  axi_old_r_addr_bus;

// ===== old_o =====
reg [Q_TILES*16-1:0] axi_old_o_data_in_bus;
reg [Q_TILES-1:0]       axi_old_o_we_bus;
reg [Q_TILES-1:0]        axi_old_o_en_bus;
reg [Q_TILES*17-1:0] axi_old_o_addr_bus;

// ---------- ctrl ----------
reg qk_mem_array_en_in;

// ---------- output ----------
reg [Q_TILES-1:0]     axi_new_r_en_bus;
reg [Q_TILES*10-1:0]  axi_new_r_addr_bus;
wire[Q_TILES*16-1:0]  new_r_data_out_bus;
wire [Q_TILES-1:0]    new_r_valid_bus;


reg [Q_TILES-1:0]  axi_new_m_en_bus;
reg [Q_TILES*10-1:0]  axi_new_m_addr_bus;
wire [Q_TILES*16-1:0] new_m_data_out_bus;
wire[Q_TILES-1:0]        new_m_valid_bus;

reg [Q_TILES-1:0]  axi_new_o_en_bus;
reg [Q_TILES*17-1:0]  axi_new_o_addr_bus;
wire [Q_TILES*16-1:0] new_o_data_out_bus;
wire [Q_TILES-1:0]       new_o_valid_bus;

wire[Q_TILES-1:0]       iter_done_bus;
// ======================================================
// DUT
// ======================================================
flashattention_with_bram_unit #(
   .TOKENS(TOKENS),
    .HEAD_DIM(HEAD_DIM),
    .Q_TILES(Q_TILES),
    .inv_sqrt_head_dim(inv_sqrt_head_dim)
)dut(
    .clk(clk),
    .axi_clk(axi_clk),
    .rst_n(rst_n),

    // =========================
    // AXI 写接口（K / Q / V）
    // =========================
    .axi_k_data_in_bus(axi_k_data_in_bus),
    .axi_k_we_in_bus(axi_k_we_in_bus),
    .axi_k_en_in_bus(axi_k_en_in_bus),
    .axi_k_addr_in_bus(axi_k_addr_in_bus),

    .axi_q_data_in_bus(axi_q_data_in_bus),
    .axi_q_we_in_bus(axi_q_we_in_bus),
    .axi_q_en_in_bus(axi_q_en_in_bus),
    .axi_q_addr_in_bus(axi_q_addr_in_bus),

    .axi_v_data_in_bus(axi_v_data_in_bus),
    .axi_v_we_in_bus(axi_v_we_in_bus),
    .axi_v_en_in_bus(axi_v_en_in_bus),
    .axi_v_addr_in_bus(axi_v_addr_in_bus),

    // =========================
    // OLD 数据接口（每个 tile）
    // =========================
    .axi_old_m_data_in_bus(axi_old_m_data_in_bus),
    .axi_old_m_we_bus(axi_old_m_we_bus),
    .axi_old_m_en_bus(axi_old_m_en_bus),
    .axi_old_m_addr_bus(axi_old_m_addr_bus),

    .axi_old_r_data_in_bus(axi_old_r_data_in_bus),
    .axi_old_r_we_bus(axi_old_r_we_bus),
    .axi_old_r_en_bus(axi_old_r_en_bus),
    .axi_old_r_addr_bus(axi_old_r_addr_bus),

    .axi_old_o_data_in_bus(axi_old_o_data_in_bus),
    .axi_old_o_we_bus(axi_old_o_we_bus),
    .axi_old_o_en_bus(axi_old_o_en_bus),
    .axi_old_o_addr_bus(axi_old_o_addr_bus),

    // =========================
    // NEW 数据读取接口
    // =========================
    .axi_new_m_en_bus(axi_new_m_en_bus),
    .axi_new_m_addr_bus(axi_new_m_addr_bus),
    .new_m_data_out_bus(new_m_data_out_bus),
    .new_m_valid_bus(new_m_valid_bus),

    .axi_new_r_en_bus(axi_new_r_en_bus),
    .axi_new_r_addr_bus(axi_new_r_addr_bus),
    .new_r_data_out_bus(new_r_data_out_bus),
    .new_r_valid_bus(new_r_valid_bus),

    .axi_new_o_en_bus(axi_new_o_en_bus),
    .axi_new_o_addr_bus(axi_new_o_addr_bus),
    .new_o_data_out_bus(new_o_data_out_bus),
    .new_o_valid_bus(new_o_valid_bus),

    // 控制
    .qk_mem_array_en_in(qk_mem_array_en_in),

    // 完成信号
    .iter_done_bus(iter_done_bus)
);

// ======================================================
// MEM定义（按你要求：一维）
// ======================================================

// Q矩阵
reg [15:0] Q_mem [0:TOKENS*HEAD_DIM-1];

// K矩阵
reg [15:0] K_mem [0:TOKENS*HEAD_DIM-1];

// V矩阵
reg [15:0] V_mem [0:TOKENS*HEAD_DIM-1];

reg [15:0] old_m_mem [0:TOKENS-1];
reg [15:0] old_r_mem [0:TOKENS-1];
reg [15:0] old_o_mem [0:TOKENS*HEAD_DIM-1];


// ======================================================
// 读取mem文件
// ======================================================

initial 
begin
    $display("Loading memory files...");

    $readmemh("Q.mem", Q_mem);
    $readmemh("K.mem", K_mem);
    $readmemh("V.mem", V_mem);
    $readmemh("old_m.mem", old_m_mem);
    $readmemh("old_R.mem", old_r_mem);
    $readmemh("old_O.mem", old_o_mem);

    $display("Memory loaded.");
end

// ======================================================
// 保存计算结果
// ======================================================

integer new_R_fout;
integer new_m_fout;
integer new_O_fout;

initial 
begin
    new_R_fout = $fopen("new_R_output.mem","w");
    new_m_fout = $fopen("new_m_output.mem","w");
    new_O_fout = $fopen("new_O_output.mem","w");
end

always @(posedge clk)
begin
    for (integer tile = 0; tile < Q_TILES; tile = tile + 1)
    begin
        if(new_r_valid_bus[tile]) $fdisplay(new_R_fout, "%h", new_r_data_out_bus[tile*16 +: 16]);
        if(new_m_valid_bus[tile]) $fdisplay(new_m_fout, "%h", new_m_data_out_bus[tile*16 +: 16]);
        if(new_o_valid_bus[tile]) $fdisplay(new_O_fout, "%h", new_o_data_out_bus[tile*16 +: 16]);
    end
    
end

// ======================================================
// 写 K（列并行写入）
// ======================================================
task write_K;
    integer token, dim;
    begin
        for(token = 0; token < TOKENS; token = token + 1) begin

            @(posedge axi_clk);

            for(dim = 0; dim < HEAD_DIM; dim = dim + 1) begin
                axi_k_data_in_bus[dim*16 +: 16] <= K_mem[token*HEAD_DIM + dim];

                axi_k_addr_in_bus[dim*11 +: 11] <= token;
            end

            axi_k_we_in_bus <= {HEAD_DIM{1'b1}};
            axi_k_en_in_bus <= {HEAD_DIM{1'b1}};
        end

        @(posedge axi_clk);
        axi_k_we_in_bus <= 0;
        axi_k_en_in_bus <= 0;
    end

endtask

// ======================================================
// 写 V（列并行写入）
// ======================================================
task write_V;
    integer token, dim;
    begin
        for(token = 0; token < TOKENS; token = token + 1) begin

            @(posedge axi_clk);

            for(dim = 0; dim < HEAD_DIM; dim = dim + 1) begin
                axi_v_data_in_bus[dim*16 +: 16] <= V_mem[token*HEAD_DIM + dim];

                axi_v_addr_in_bus[dim*11 +: 11] <= token;
            end

            axi_v_we_in_bus <= {HEAD_DIM{1'b1}};
            axi_v_en_in_bus <= {HEAD_DIM{1'b1}};
        end

        @(posedge axi_clk);
        axi_v_we_in_bus <= 0;
        axi_v_en_in_bus <= 0;
    end

endtask


// ======================================================
// 写 Q（tile + 列）
// ======================================================
task write_Q;
    integer tile, token, dim;
    integer tile_tokens;
    begin
        tile_tokens = TOKENS / Q_TILES;

        for(tile = 0; tile < Q_TILES; tile = tile + 1) begin
            for(token = 0; token < tile_tokens; token = token + 1) begin

                @(posedge axi_clk);

                for(dim = 0; dim < HEAD_DIM; dim = dim + 1) begin
                    axi_q_data_in_bus[(tile*HEAD_DIM+dim)*16 +:16] 
                        <= Q_mem[(tile*tile_tokens + token)*HEAD_DIM + dim];

                    axi_q_addr_in_bus[(tile*HEAD_DIM+dim)*10 +:10] 
                        <= token;
                end

                axi_q_we_in_bus <= {(Q_TILES*HEAD_DIM){1'b1}};
                axi_q_en_in_bus <= {(Q_TILES*HEAD_DIM){1'b1}};
            end
        end

        @(posedge axi_clk);
        axi_q_we_in_bus <= 0;
        axi_q_en_in_bus <= 0;
    end

endtask

task write_old_m_r;
    integer tile, i;
    integer base;
begin
    for(i = 0; i < (TOKENS / Q_TILES); i = i + 1) 
    begin

        @(posedge axi_clk);
        for(tile = 0; tile < Q_TILES; tile = tile + 1) 
        begin
           
            base = tile * (TOKENS / Q_TILES);
            // ===== old_m =====
            axi_old_m_en_bus[tile]   <= 1;
            axi_old_m_we_bus[tile]   <= 1;
            axi_old_m_addr_bus[tile*10 +: 10] <= i;
            axi_old_m_data_in_bus[tile*16 +: 16] <= old_m_mem[base + i];

            // ===== old_r =====
            axi_old_r_en_bus[tile]   <= 1;
            axi_old_r_we_bus[tile]   <= 1;
            axi_old_r_addr_bus[tile*10 +: 10] <= i;
            axi_old_r_data_in_bus[tile*16 +: 16] <= old_r_mem[base + i];
        end
    end

     // 关闭写
    @(posedge axi_clk);
// ===== 统一关闭 =====
    for(tile = 0; tile < Q_TILES; tile = tile + 1) begin
        axi_old_m_en_bus[tile] <= 0;
        axi_old_m_we_bus[tile] <= 0;

        axi_old_r_en_bus[tile] <= 0;
        axi_old_r_we_bus[tile] <= 0;
    end

end
endtask

task write_old_o;
    integer tile, i;
    integer tile_size;
begin
    tile_size = TOKENS*HEAD_DIM/Q_TILES;

    for(i = 0; i < tile_size; i = i + 1) begin
        @(posedge axi_clk);
        // ===== 并行写 =====
        for(tile = 0; tile < Q_TILES; tile = tile + 1) begin
            axi_old_o_en_bus[tile]   <= 1;
            axi_old_o_we_bus[tile]   <= 1;
            axi_old_o_addr_bus[tile*17 +: 17] <= i;
            axi_old_o_data_in_bus[tile*16 +: 16] <= old_o_mem[i + tile*tile_size];
        end
    end

    @(posedge axi_clk);
    // ===== 统一关闭 =====
    for(tile = 0; tile < Q_TILES; tile = tile + 1) begin
        axi_old_o_en_bus[tile] <= 0;
        axi_old_o_we_bus[tile] <= 0;
    end
end
endtask

task read_new_m;
    integer tile, i,TILE;
begin
    $display("\n---- READ NEW M ----");

    for(tile = 0; tile < Q_TILES; tile = tile + 1) 
    begin
        for(i = 0; i < (TOKENS / Q_TILES); i = i + 1)
        begin
            @(posedge axi_clk);
            for(TILE = 0; TILE < Q_TILES; TILE = TILE + 1)
            begin
                if(TILE == tile)
                begin
                    axi_new_m_en_bus[TILE]   <= 1;
                    axi_new_m_addr_bus[TILE*10 +: 10] <= i;
                end
                else 
                begin
                    axi_new_m_en_bus[TILE]   <= 0;
                    axi_new_m_addr_bus[TILE*10 +: 10] <= 0;
                end
            end
        end
    end

    @(posedge axi_clk);
    // 关闭
    for(tile = 0; tile < Q_TILES; tile = tile + 1) 
    begin
        axi_new_m_en_bus[tile] <= 0;
    end
end
endtask

task read_new_r;
    integer tile, i,TILE;
begin
    $display("\n---- READ NEW R ----");

    for(tile = 0; tile < Q_TILES; tile = tile + 1) 
    begin
        // 发地址
        for(i = 0; i < (TOKENS / Q_TILES); i = i + 1)
        begin
            @(posedge axi_clk);
            for(TILE = 0; TILE < Q_TILES; TILE = TILE + 1)
            begin
                if(TILE == tile)
                begin
                    axi_new_r_en_bus[TILE]   <= 1;
                    axi_new_r_addr_bus[TILE*10 +: 10] <= i;
                end
                else 
                begin
                    axi_new_r_en_bus[TILE]   <= 0;
                    axi_new_r_addr_bus[TILE*10 +: 10] <= 0;
                end
            end
        end

    end

    @(posedge axi_clk);
    // 关闭
    for(tile = 0; tile < Q_TILES; tile = tile + 1) 
    begin
        axi_new_r_en_bus[tile] <= 0;
    end
end
endtask

task read_new_o;
    integer tile, i,TILE;
begin
    $display("\n---- READ NEW O ----");

    for(tile = 0; tile < Q_TILES; tile = tile + 1)  
    begin
        // 发地址
        for(i = 0; i < (TOKENS*HEAD_DIM / Q_TILES); i = i + 1) 
        begin
            @(posedge axi_clk);
            for(TILE = 0; TILE < Q_TILES; TILE = TILE + 1)
            begin
                if(TILE == tile)
                begin
                    axi_new_o_en_bus[TILE]   <= 1;
                    axi_new_o_addr_bus[TILE*17 +: 17] <= i;
                end
                else 
                begin
                    axi_new_o_en_bus[TILE]   <= 0;
                    axi_new_o_addr_bus[TILE*17 +: 17] <= 0;
                end
            end
        end
    end

    // 关闭
    @(posedge axi_clk);
    for(tile = 0; tile < Q_TILES; tile = tile + 1) begin
        axi_new_o_en_bus[tile] <= 0;
    end
end
endtask

// ======================================================
// 主流程
// ======================================================
initial begin
    rst_n = 0;
    qk_mem_array_en_in = 0;

    axi_k_we_in_bus = 0;
    axi_k_en_in_bus = 0;
    axi_q_we_in_bus = 0;
    axi_q_en_in_bus = 0;

    #10;
    rst_n = 1;

    // 写入数据
    fork
        write_K();
        write_Q();
        write_V();
        write_old_m_r();
        write_old_o();
    join

    // 启动计算
    @(posedge clk);
    qk_mem_array_en_in <= 1;
    wait(iter_done_bus[0] && iter_done_bus[1]); 

    fork
        read_new_m();
        read_new_r();
        read_new_o();
    join
    
    #100;
    $fflush(new_m_fout);
    $fflush(new_R_fout);
    $fflush(new_O_fout);
    $stop;
end


endmodule
