`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/11 15:46:52
// Design Name: 
// Module Name: tb_flashattention2_with_bram_unit
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


module tb_flashattention2_with_bram_unit;
parameter TOKENS   = 32;//tokens per tile 
parameter HEAD_DIM = 4;//feature dim per attention head
parameter Q_TILES  = 2;  //number of pe array sets,per set include a ws/os pe array 
                         //safe_softmax_unit,iter_unit,output_buffer 
parameter TOTAL_TOKENS = 64;//
parameter inv_sqrt_head_dim = 16'h3800;
// parameter inv_sqrt_head_dim = 16'h2da8;
parameter KV_MEM_HALF = 1024;
parameter Q_MEM_HALF = 512;
parameter ITER_NUM = TOTAL_TOKENS/TOKENS;

// ======================================================
// 时钟 & Reset
// ======================================================
reg clk;
reg axi_to_bram_clk;
reg bram_to_axi_clk;
reg rst_n;

initial clk = 1;
always #1 clk = ~clk;

initial axi_to_bram_clk = 1;
always #1 axi_to_bram_clk = ~axi_to_bram_clk;

initial bram_to_axi_clk = 1;
always #1 bram_to_axi_clk = ~bram_to_axi_clk;

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

// ---------- ctrl ----------
reg qk_mem_array_en_in;
reg[7:0] iter_num_in;
reg iter_num_valid_in;

// ---------- output ----------

reg [Q_TILES-1:0]     o_result_read_en_in_bus;
reg [Q_TILES*16-1:0]  o_result_read_addr_in_bus;
wire [Q_TILES*16-1:0] o_result_read_data_out_bus;
wire [Q_TILES-1:0]       o_result_read_valid_out_bus;

wire[Q_TILES-1:0]       single_iter_done_out_bus;
wire[Q_TILES-1:0]       all_iter_done_out_bus;


integer kv_batch_id;
integer q_batch_id;
integer loop_num;
integer o_result_tiles;

reg kv_pingpang_mode;
reg q_pingpang_mode;
// ======================================================
// DUT
// ======================================================
flashattention2_with_bram_unit #(
   .TOKENS(TOKENS),
    .HEAD_DIM(HEAD_DIM),
    .Q_TILES(Q_TILES),
    .inv_sqrt_head_dim(inv_sqrt_head_dim)
)dut(

    .clk(clk),
    .axi_to_bram_clk(axi_to_bram_clk),
    .bram_to_axi_clk(bram_to_axi_clk),
    .rst_n(rst_n),

    // 控制
    .qk_mem_array_en_in(qk_mem_array_en_in),
    .iter_num_in(iter_num_in),
    .iter_num_valid_in(iter_num_valid_in),

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

    .o_result_read_en_in_bus(o_result_read_en_in_bus),
    .o_result_read_addr_in_bus(o_result_read_addr_in_bus),
    .o_result_read_data_out_bus(o_result_read_data_out_bus),
    .o_result_read_valid_out_bus(o_result_read_valid_out_bus),

    // 完成信号
    .single_iter_done_out_bus(single_iter_done_out_bus),
    .all_iter_done_out_bus(all_iter_done_out_bus)
);

// ======================================================
// MEM定义（按你要求：一维）
// ======================================================

// Q矩阵
reg [15:0] Q_mem [0:TOTAL_TOKENS*HEAD_DIM-1];

// K矩阵
reg [15:0] K_mem [0:TOTAL_TOKENS*HEAD_DIM-1];

// V矩阵
reg [15:0] V_mem [0:TOTAL_TOKENS*HEAD_DIM-1];



// ======================================================
// 读取mem文件
// ======================================================

initial 
begin
    $display("Loading memory files...");

    // $readmemh("Q2048x128.mem", Q_mem);
    // $readmemh("K2048x128.mem", K_mem);
    // $readmemh("V2048x128.mem", V_mem);

    // $readmemh("Q2048x4.mem", Q_mem);
    // $readmemh("K2048x4.mem", K_mem);
    // $readmemh("V2048x4.mem", V_mem);

    // $readmemh("Q128x4.mem", Q_mem);
    // $readmemh("K128x4.mem", K_mem);
    // $readmemh("V128x4.mem", V_mem);

    $readmemh("Q64x4.mem", Q_mem);
    $readmemh("K64x4.mem", K_mem);
    $readmemh("V64x4.mem", V_mem);

    $display("Memory loaded.");
end

// ======================================================
// 保存计算结果
// ======================================================

integer O_normalized_fout;

initial 
begin
    O_normalized_fout = $fopen("O_normalized_output.mem","w");
end

always @(posedge bram_to_axi_clk)
begin
    for (integer tile = 0; tile < Q_TILES; tile = tile + 1)
    begin
        if(o_result_read_valid_out_bus[tile]) $fdisplay(O_normalized_fout, "%h", o_result_read_data_out_bus[tile*16 +: 16]);
    end
    
end

// ======================================================
// 写 K（列并行写入）
// ======================================================
task write_K;
    input integer batch_id_in;
    input integer pingpong_mode_in;

    integer token, dim;
    integer base_offset;
    integer ping_offset;

    begin
        base_offset = batch_id_in * TOKENS;
        ping_offset = pingpong_mode_in ? KV_MEM_HALF : 0;

        for(token = 0; token < TOKENS; token = token + 1) begin

            @(posedge axi_to_bram_clk);

            for(dim = 0; dim < HEAD_DIM; dim = dim + 1) begin
                axi_k_data_in_bus[dim*16 +: 16] 
                    <= K_mem[(base_offset + token)*HEAD_DIM + dim];

                axi_k_addr_in_bus[dim*11 +: 11] 
                    <= token + ping_offset;
            end

            axi_k_we_in_bus <= {HEAD_DIM{1'b1}};
            axi_k_en_in_bus <= {HEAD_DIM{1'b1}};
        end

        @(posedge axi_to_bram_clk);
        axi_k_we_in_bus <= 0;
        axi_k_en_in_bus <= 0;
    end
endtask

// ======================================================
// 写 V（列并行写入）
// ======================================================
task write_V;
    input integer batch_id_in;
    input integer pingpong_mode_in;

    integer token, dim;
    integer base_offset;
    integer ping_offset;

    begin
        base_offset = batch_id_in * TOKENS;
        ping_offset = pingpong_mode_in ? KV_MEM_HALF : 0;

        for(token = 0; token < TOKENS; token = token + 1) begin

            @(posedge axi_to_bram_clk);

            for(dim = 0; dim < HEAD_DIM; dim = dim + 1) begin
                axi_v_data_in_bus[dim*16 +: 16] 
                    <= V_mem[(base_offset + token)*HEAD_DIM + dim];

                axi_v_addr_in_bus[dim*11 +: 11] 
                    <= token + ping_offset;
            end

            axi_v_we_in_bus <= {HEAD_DIM{1'b1}};
            axi_v_en_in_bus <= {HEAD_DIM{1'b1}};
        end

        @(posedge axi_to_bram_clk);
        axi_v_we_in_bus <= 0;
        axi_v_en_in_bus <= 0;
    end
endtask

// ======================================================
// 写 Q（tile + 列）
// ======================================================
task write_Q;
    input integer batch_id_in;
    input integer pingpong_mode_in;

    integer tile, token, dim;
    integer tile_tokens;
    integer base_offset;
    integer ping_offset;

    begin
        tile_tokens = TOKENS / Q_TILES;

        base_offset = batch_id_in * TOKENS;
        ping_offset = pingpong_mode_in ? Q_MEM_HALF : 0;

        for(tile = 0; tile < Q_TILES; tile = tile + 1) begin
            for(token = 0; token < tile_tokens; token = token + 1) begin

                @(posedge axi_to_bram_clk);

                for(dim = 0; dim < HEAD_DIM; dim = dim + 1) begin

                    axi_q_data_in_bus[(tile*HEAD_DIM+dim)*16 +:16] 
                        <= Q_mem[(base_offset + tile*tile_tokens + token)*HEAD_DIM + dim];

                    axi_q_addr_in_bus[(tile*HEAD_DIM+dim)*10 +:10] 
                        <= token + ping_offset;
                end

                axi_q_we_in_bus <= {(Q_TILES*HEAD_DIM){1'b1}};
                axi_q_en_in_bus <= {(Q_TILES*HEAD_DIM){1'b1}};
            end
        end

        @(posedge axi_to_bram_clk);
        axi_q_we_in_bus <= 0;
        axi_q_en_in_bus <= 0;
    end
endtask

task read_O_result;
    integer tile, i,TILE;
begin
    $display("\n---- READ NEW O ----");

    for(tile = 0; tile < Q_TILES; tile = tile + 1)  
    begin
        // 发地址
        for(i = 0; i < (TOKENS*HEAD_DIM / Q_TILES); i = i + 1) 
        begin
            @(posedge bram_to_axi_clk);
            for(TILE = 0; TILE < Q_TILES; TILE = TILE + 1)
            begin
                if(TILE == tile)
                begin
                    o_result_read_en_in_bus[TILE]   <= 1;
                    o_result_read_addr_in_bus[TILE*16 +: 16] <= i;
                end
                else 
                begin
                    o_result_read_en_in_bus[TILE]   <= 0;
                    o_result_read_addr_in_bus[TILE*16 +: 16] <= 0;
                end
            end
        end
    end

    // 关闭
    @(posedge bram_to_axi_clk);
    for(tile = 0; tile < Q_TILES; tile = tile + 1) begin
        o_result_read_en_in_bus[tile] <= 0;
    end
end
endtask

// ======================================================
// 主流程
// ======================================================
initial begin
    rst_n = 0;
    qk_mem_array_en_in = 0;
    iter_num_in = 0;
    iter_num_valid_in = 0;
    
    kv_pingpang_mode = 0;
    q_pingpang_mode = 0;

    kv_batch_id = 2;
    q_batch_id = 2; 

    o_result_tiles = 0;

    loop_num = 0;

    #10;
    rst_n <= 1;

    // ========= 首批送入 =========
    fork
        write_K(0, 0);
        write_Q(0, 0);
        write_V(0, 0);
    join

    fork
        write_K(1, 1);
        write_Q(1, 1);
        write_V(1, 1);
    join

    @(posedge clk);
    iter_num_in <= ITER_NUM;
    iter_num_valid_in <= 1;

    @(posedge clk);
    iter_num_in <= 0;
    iter_num_valid_in <= 0;

    @(posedge clk);
    qk_mem_array_en_in <= 1;

    // wait(single_iter_done_out_bus[0]);

    fork
        while (loop_num < ITER_NUM && ITER_NUM > 2)
        begin
            @(posedge axi_to_bram_clk);
            if(single_iter_done_out_bus[0] && single_iter_done_out_bus[1])
            begin
                if(loop_num < ITER_NUM && ITER_NUM > 2)
                begin
                    fork
                        write_K(kv_batch_id, kv_pingpang_mode);
                        write_V(kv_batch_id, kv_pingpang_mode);
                    join

                    if(kv_batch_id < ITER_NUM - 1)
                    begin
                        kv_batch_id = kv_batch_id + 1;
                    end
                    else
                    begin
                        kv_batch_id = 0;
                        loop_num = loop_num + 1;
                    end

                    kv_pingpang_mode = ~kv_pingpang_mode;
                end
            end
        end

        while (q_batch_id < ITER_NUM && ITER_NUM > 2)
        begin
            @(posedge axi_to_bram_clk);
            if(all_iter_done_out_bus[0] && all_iter_done_out_bus[1])
            begin
                if(q_batch_id < ITER_NUM && ITER_NUM > 2)
                begin
                    write_Q(q_batch_id, q_pingpang_mode);

                    q_batch_id = q_batch_id + 1;
                    q_pingpang_mode = ~q_pingpang_mode;
                end
            end
        end

        while (o_result_tiles < ITER_NUM)
        begin
            @(posedge bram_to_axi_clk);
            if(all_iter_done_out_bus[0] && all_iter_done_out_bus[1])
            begin
                if(o_result_tiles < ITER_NUM)
                begin
                    read_O_result();
                    o_result_tiles = o_result_tiles + 1;
                end
            end
        end
    join

    @(posedge clk);
    qk_mem_array_en_in <= 0;

    #100;
    $fflush(O_normalized_fout);
    $stop;
end

endmodule
