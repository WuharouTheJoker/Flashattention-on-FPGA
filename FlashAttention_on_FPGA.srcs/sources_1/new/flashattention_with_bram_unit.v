`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/01 00:16:29
// Design Name: 
// Module Name: flashattention_with_bram_unit
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
module flashattention_with_bram_unit #(
    parameter TOKENS   = 1024,
    parameter HEAD_DIM = 4,
    parameter Q_TILES  = 2,
    parameter inv_sqrt_head_dim = 16'h3800
    // parameter inv_sqrt_head_dim = 16'h2da8  
)(
    input clk,
    input axi_to_bram_clk,
    input rst_n,
    input qk_mem_array_en_in,

    // =========================
    // K
    // =========================
    input  [HEAD_DIM*16-1:0] axi_k_data_in_bus,
    input  [HEAD_DIM-1:0]    axi_k_we_in_bus,
    input  [HEAD_DIM-1:0]    axi_k_en_in_bus,
    input  [HEAD_DIM*11-1:0] axi_k_addr_in_bus,

    // =========================
    // Q
    // =========================
    input  [Q_TILES*HEAD_DIM*16-1:0] axi_q_data_in_bus,
    input  [Q_TILES*HEAD_DIM-1:0]    axi_q_we_in_bus,
    input  [Q_TILES*HEAD_DIM-1:0]    axi_q_en_in_bus,
    input  [Q_TILES*HEAD_DIM*10-1:0] axi_q_addr_in_bus,

    // =========================
    // V
    // =========================
    input  [HEAD_DIM*16-1:0] axi_v_data_in_bus,
    input  [HEAD_DIM-1:0]    axi_v_we_in_bus,
    input  [HEAD_DIM-1:0]    axi_v_en_in_bus,
    input  [HEAD_DIM*11-1:0] axi_v_addr_in_bus,

    // =========================
    // OLD（全部改成 packed）
    // =========================
    input  [Q_TILES*16-1:0]  axi_old_m_data_in_bus,
    input  [Q_TILES-1:0]     axi_old_m_we_bus,
    input  [Q_TILES-1:0]     axi_old_m_en_bus,
    input  [Q_TILES*10-1:0]  axi_old_m_addr_bus,

    input  [Q_TILES*16-1:0]  axi_old_r_data_in_bus,
    input  [Q_TILES-1:0]     axi_old_r_we_bus,
    input  [Q_TILES-1:0]     axi_old_r_en_bus,
    input  [Q_TILES*10-1:0]  axi_old_r_addr_bus,

    input  [Q_TILES*16-1:0]  axi_old_o_data_in_bus,
    input  [Q_TILES-1:0]     axi_old_o_we_bus,
    input  [Q_TILES-1:0]     axi_old_o_en_bus,
    input  [Q_TILES*17-1:0]  axi_old_o_addr_bus,

    // =========================
    // NEW（读接口）
    // =========================
    input  [Q_TILES-1:0]     axi_new_m_en_bus,
    input  [Q_TILES*10-1:0]  axi_new_m_addr_bus,
    output [Q_TILES*16-1:0]  new_m_data_out_bus,
    output [Q_TILES-1:0]     new_m_valid_bus,

    input  [Q_TILES-1:0]     axi_new_r_en_bus,
    input  [Q_TILES*10-1:0]  axi_new_r_addr_bus,
    output [Q_TILES*16-1:0]  new_r_data_out_bus,
    output [Q_TILES-1:0]     new_r_valid_bus,

    input  [Q_TILES-1:0]     axi_new_o_en_bus,
    input  [Q_TILES*17-1:0]  axi_new_o_addr_bus,
    output [Q_TILES*16-1:0]  new_o_data_out_bus,
    output [Q_TILES-1:0]     new_o_valid_bus,

    output [Q_TILES-1:0]       iter_done_bus
);

    // =====================================================
    // 中间信号
    // =====================================================
    wire [HEAD_DIM*16-1:0] k_data_out_bus;
    wire [HEAD_DIM-1:0]    k_data_out_valid_bus;

    wire [Q_TILES*HEAD_DIM*16-1:0] q_data_out_bus;
    wire [Q_TILES*HEAD_DIM-1:0]    q_data_out_valid_bus;

    wire [HEAD_DIM*16-1:0] v_data_out_bus;
    wire [HEAD_DIM-1:0]    v_data_out_valid_bus;

    wire [Q_TILES-1:0] v_mem_array_en_out;

    // =====================================================
    // QK
    // =====================================================
    qk_mem_array_with_ctrl #(
        .TOKENS(TOKENS),
        .HEAD_DIM(HEAD_DIM),
        .Q_TILES(Q_TILES)
    ) u_qk (
        .rst_n(rst_n),
        .axi_to_bram_clk(axi_to_bram_clk),

        .axi_k_data_in_bus(axi_k_data_in_bus),
        .axi_k_we_in_bus(axi_k_we_in_bus),
        .axi_k_en_in_bus(axi_k_en_in_bus),
        .axi_k_addr_in_bus(axi_k_addr_in_bus),

        .axi_q_data_in_bus(axi_q_data_in_bus),
        .axi_q_we_in_bus(axi_q_we_in_bus),
        .axi_q_en_in_bus(axi_q_en_in_bus),
        .axi_q_addr_in_bus(axi_q_addr_in_bus),

        .clk(clk),
        .qk_mem_array_en_in(qk_mem_array_en_in),

        .k_data_out_bus(k_data_out_bus),
        .k_data_out_valid_bus(k_data_out_valid_bus),

        .q_data_out_bus(q_data_out_bus),
        .q_data_out_valid_bus(q_data_out_valid_bus)
    );

    // =====================================================
    // V
    // =====================================================
    v_mem_array_with_ctrl #(
        .TOKENS(TOKENS),
        .HEAD_DIM(HEAD_DIM),
        .Q_TILES(Q_TILES)
    ) u_v (
        .rst_n(rst_n),
        .axi_to_bram_clk(axi_to_bram_clk),

        .axi_v_data_in_bus(axi_v_data_in_bus),
        .axi_v_we_in_bus(axi_v_we_in_bus),
        .axi_v_en_in_bus(axi_v_en_in_bus),
        .axi_v_addr_in_bus(axi_v_addr_in_bus),

        .clk(clk),
        .v_mem_array_en_in(v_mem_array_en_out[0]),

        .v_data_out_bus(v_data_out_bus),
        .v_data_out_valid_bus(v_data_out_valid_bus)
    );

    // =====================================================
    // TILE 级联
    // =====================================================
    genvar i;
    generate
    for(i = 0; i < Q_TILES; i = i + 1) begin : TILE

        wire [HEAD_DIM*16-1:0] q_tile_bus;
        wire [HEAD_DIM-1:0]    q_tile_valid;

        assign q_tile_bus   = q_data_out_bus[i*HEAD_DIM*16 +: HEAD_DIM*16];
        assign q_tile_valid = q_data_out_valid_bus[i*HEAD_DIM +: HEAD_DIM];

        wire [15:0] local_r;
        wire        local_r_valid;
        wire [15:0] local_m;
        wire        local_m_valid;
        wire [15:0] local_o;
        wire        local_o_valid;

        streaming_matrix_mul_unit #(
            .TOKENS(TOKENS),
            .HEAD_DIM(HEAD_DIM),
            .inv_sqrt_head_dim(inv_sqrt_head_dim)
        )u_compute (
            .clk(clk),
            .rst_n(rst_n),

            .q_in_bus(q_tile_bus),
            .q_in_valid_bus(q_tile_valid),

            .k_in_bus(k_data_out_bus),
            .k_in_valid_bus(k_data_out_valid_bus),

            .v_in_bus(v_data_out_bus),
            .v_in_valid_bus(v_data_out_valid_bus),

            .v_mem_array_en_out(v_mem_array_en_out[i]),

            .local_r_out(local_r),
            .local_r_valid_out(local_r_valid),

            .local_m_out(local_m),
            .local_m_valid_out(local_m_valid),

            .local_o_out(local_o),
            .local_o_out_valid(local_o_valid)
        );

        iter_unit #(
            .Q_TOKENS(TOKENS/Q_TILES),
            .HEAD_DIM(HEAD_DIM)
        ) u_iter (

            .rst_n(rst_n),
            .clk(clk),
            .axi_to_bram_clk(axi_to_bram_clk),

            // ===== OLD =====
            .axi_old_m_data_in(axi_old_m_data_in_bus[i*16 +:16]),
            .axi_old_m_we_in(axi_old_m_we_bus[i]),
            .axi_old_m_en_in(axi_old_m_en_bus[i]),
            .axi_old_m_addr_in(axi_old_m_addr_bus[i*10 +:10]),

            .axi_old_r_data_in(axi_old_r_data_in_bus[i*16 +:16]),
            .axi_old_r_we_in(axi_old_r_we_bus[i]),
            .axi_old_r_en_in(axi_old_r_en_bus[i]),
            .axi_old_r_addr_in(axi_old_r_addr_bus[i*10 +:10]),

            .axi_old_o_data_in(axi_old_o_data_in_bus[i*16 +:16]),
            .axi_old_o_we_in(axi_old_o_we_bus[i]),
            .axi_old_o_en_in(axi_old_o_en_bus[i]),
            .axi_old_o_addr_in(axi_old_o_addr_bus[i*17 +:17]),

            // ===== LOCAL =====
            .local_m_data_in(local_m),
            .local_m_data_valid_in(local_m_valid),

            .local_r_data_in(local_r),
            .local_r_data_valid_in(local_r_valid),

            .local_o_data_in(local_o),
            .local_o_data_valid_in(local_o_valid),

            // ===== NEW =====
            .axi_new_m_en_in(axi_new_m_en_bus[i]),
            .axi_new_m_addr_in(axi_new_m_addr_bus[i*10 +:10]),
            .axi_new_m_data_out(new_m_data_out_bus[i*16 +:16]),
            .axi_new_m_valid_out(new_m_valid_bus[i]),

            .axi_new_r_en_in(axi_new_r_en_bus[i]),
            .axi_new_r_addr_in(axi_new_r_addr_bus[i*10 +:10]),
            .axi_new_r_data_out(new_r_data_out_bus[i*16 +:16]),
            .axi_new_r_valid_out(new_r_valid_bus[i]),

            .axi_new_o_en_in(axi_new_o_en_bus[i]),
            .axi_new_o_addr_in(axi_new_o_addr_bus[i*17 +:17]),
            .axi_new_o_data_out(new_o_data_out_bus[i*16 +:16]),
            .axi_new_o_valid_out(new_o_valid_bus[i]),

            .iter_unit_done_out(iter_done_bus[i])
        );

    end
    endgenerate

endmodule