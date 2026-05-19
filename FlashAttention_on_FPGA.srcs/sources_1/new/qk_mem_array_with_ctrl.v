`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/30 15:31:14
// Design Name: 
// Module Name: v_mem_array_with_ctrl
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
module qk_mem_array_with_ctrl #(
    parameter TOKENS = 8,
    parameter HEAD_DIM = 4,
    parameter Q_TILES = 2
)(
    input                           rst_n,

    input                           axi_to_bram_clk,
    // =========================
    // K
    // =========================
    input [HEAD_DIM*16-1:0]         axi_k_data_in_bus,
    input [HEAD_DIM-1:0]            axi_k_we_in_bus,
    input [HEAD_DIM-1:0]            axi_k_en_in_bus,
    input [HEAD_DIM*11-1:0]         axi_k_addr_in_bus,
    // =========================
    // Q
    // =========================
    input [Q_TILES*HEAD_DIM*16-1:0] axi_q_data_in_bus,
    input [Q_TILES*HEAD_DIM-1:0]    axi_q_we_in_bus,
    input [Q_TILES*HEAD_DIM-1:0]    axi_q_en_in_bus,
    input [Q_TILES*HEAD_DIM*10-1:0] axi_q_addr_in_bus,  

    input                           clk,
    input                           qk_mem_array_en_in,

    input [7:0]                     iter_num_in,
    input                           iter_num_valid_in,       
    // =========================
    // output to pe array
    // =========================
    output [HEAD_DIM*16-1:0]         k_data_out_bus,
    output [HEAD_DIM-1:0]            k_data_out_valid_bus,

    output [Q_TILES*HEAD_DIM*16-1:0] q_data_out_bus,
    output [Q_TILES*HEAD_DIM-1:0]    q_data_out_valid_bus
);
    reg[7:0] iter_num_reg;

    always @(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            iter_num_reg <= 0;
        end
        else 
        begin
            if(iter_num_valid_in) iter_num_reg <= iter_num_in;
        end
    end


    // =====================================================
    // 1️⃣ K memory（单个 kv_mem_array）
    // =====================================================
    reg[9:0] k_ctrl_addr_cnt;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            k_ctrl_addr_cnt <= 0;
        end
        else if(qk_mem_array_en_in) 
        begin
            if(k_ctrl_addr_cnt < TOKENS - 1) k_ctrl_addr_cnt <= k_ctrl_addr_cnt + 1;
            else k_ctrl_addr_cnt <= 0;
        end
    end

    reg[8:0] q_ctrl_addr_cnt;
    reg      q_ctrl_en_wire;

    always@(*)
    begin
        q_ctrl_en_wire = (k_ctrl_addr_cnt == 0) && qk_mem_array_en_in;
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) q_ctrl_addr_cnt <= 0;
        else if(q_ctrl_en_wire) 
        begin
            if(q_ctrl_addr_cnt < TOKENS/Q_TILES - 1) q_ctrl_addr_cnt <= q_ctrl_addr_cnt + 1;
            else q_ctrl_addr_cnt <= 0;
        end
        else q_ctrl_addr_cnt <= q_ctrl_addr_cnt;
    end

    reg[9:0] loop_cnt;
    reg      loop_cnt_en_wire;
    reg      k_pingpong_mode_reg; 

    always@(*)
    begin
        loop_cnt_en_wire = (k_ctrl_addr_cnt == TOKENS - 1) && qk_mem_array_en_in; 
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
        begin
            loop_cnt <= 0;
            k_pingpong_mode_reg <= 0;
        end
        else if(loop_cnt_en_wire) 
        begin
            if(loop_cnt < TOKENS/Q_TILES - 1) 
            begin
                loop_cnt <= loop_cnt + 1;
                k_pingpong_mode_reg <= k_pingpong_mode_reg;
            end
            else 
            begin
                loop_cnt <= 0;
                k_pingpong_mode_reg <= ~k_pingpong_mode_reg;
            end
        end
        else 
        begin
            loop_cnt <= loop_cnt;
            k_pingpong_mode_reg <= k_pingpong_mode_reg;
        end
    end

    reg[7:0] iter_cnt;
    reg  iter_cnt_en_wire;
    reg  q_pingpong_mode_reg;

    always @(*) iter_cnt_en_wire = loop_cnt_en_wire && (loop_cnt == TOKENS/Q_TILES - 1);

    always @(posedge clk or negedge rst_n) 
    begin
        if(!rst_n) 
        begin
            iter_cnt <= 0;
            q_pingpong_mode_reg <= 0;
        end
        else if(iter_cnt_en_wire) 
        begin
            if(iter_cnt < iter_num_reg - 1) 
            begin
                iter_cnt <= iter_cnt + 1;
                q_pingpong_mode_reg <= q_pingpong_mode_reg;
            end
            else 
            begin
                iter_cnt <= 0;
                q_pingpong_mode_reg <= ~q_pingpong_mode_reg;
            end
        end
        else 
        begin
            iter_cnt <= iter_cnt;
            q_pingpong_mode_reg <= q_pingpong_mode_reg;
        end
    end

    kv_mem_array #(
        .HEAD_DIM(HEAD_DIM)
    ) u_k_mem_array (
        .rst_n(rst_n),

        .axi_to_bram_clk(axi_to_bram_clk),
        .axi_data_in_bus(axi_k_data_in_bus),
        .axi_we_in_bus(axi_k_we_in_bus),
        .axi_en_in_bus(axi_k_en_in_bus),
        .axi_addr_in_bus(axi_k_addr_in_bus),

        .clk(clk),
        .ctrl_addr_in({k_pingpong_mode_reg, k_ctrl_addr_cnt}),
        .ctrl_en_in(qk_mem_array_en_in),

        .kv_data_out_bus(k_data_out_bus),
        .kv_data_out_valid_bus(k_data_out_valid_bus)
    );


    // =====================================================
    // 2️⃣ Q memory（Q_TILES 个 q_mem_array）
    // =====================================================
    genvar i;
    generate
        for(i = 0; i < Q_TILES; i = i + 1) 
        begin : Q_TILE_GEN

            q_mem_array #(
                .HEAD_DIM(HEAD_DIM)
            ) u_q_mem_array (
                .rst_n(rst_n),

                // ================= AXI =================
                .axi_to_bram_clk(axi_to_bram_clk),
                .axi_data_in_bus(axi_q_data_in_bus[i*HEAD_DIM*16 +: HEAD_DIM*16]),
                .axi_we_in_bus(axi_q_we_in_bus[i*HEAD_DIM +: HEAD_DIM]),
                .axi_en_in_bus(axi_q_en_in_bus[i*HEAD_DIM +: HEAD_DIM]),
                .axi_addr_in_bus(axi_q_addr_in_bus[i*HEAD_DIM*10 +: HEAD_DIM*10]),
                // ================= CTRL =================
                .clk(clk),
                .ctrl_addr_in({q_pingpong_mode_reg, q_ctrl_addr_cnt}),
                .ctrl_en_in(q_ctrl_en_wire),
                // ================= OUT =================
                .q_data_out_bus(q_data_out_bus[i*HEAD_DIM*16 +: HEAD_DIM*16]),
                .q_data_out_valid_bus(q_data_out_valid_bus[i*HEAD_DIM +: HEAD_DIM])
            );

        end
    endgenerate

endmodule