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


module v_mem_array_with_ctrl #(
    parameter TOKENS = 8,
    parameter HEAD_DIM = 4,
    parameter Q_TILES = 2
)(
    input                           rst_n,

    input                           axi_to_bram_clk,
    // =========================
    // V
    // =========================
    input [HEAD_DIM*16-1:0]         axi_v_data_in_bus,
    input [HEAD_DIM-1:0]            axi_v_we_in_bus,
    input [HEAD_DIM-1:0]            axi_v_en_in_bus,
    input [HEAD_DIM*11-1:0]         axi_v_addr_in_bus,
   
    input                           clk,
    input                           v_mem_array_en_in,     
 
    // =========================
    // 输出
    // =========================
    output [HEAD_DIM*16-1:0]         v_data_out_bus,
    output [HEAD_DIM-1:0]            v_data_out_valid_bus


);
    reg[9:0] v_ctrl_addr_cnt;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            v_ctrl_addr_cnt <= 0;
        end
        else if(v_mem_array_en_in) 
        begin
            if(v_ctrl_addr_cnt < TOKENS - 1) v_ctrl_addr_cnt <= v_ctrl_addr_cnt + 1;
            else v_ctrl_addr_cnt <= 0;
        end
    end

    reg[9:0] loop_cnt;
    reg      loop_cnt_en_wire;
    reg      pingpong_mode_reg; 


    always@(*)
    begin
        loop_cnt_en_wire = (v_ctrl_addr_cnt == TOKENS - 1) && v_mem_array_en_in; 
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
        begin
            loop_cnt <= 0;
            pingpong_mode_reg <= 0;
        end
        else if(loop_cnt_en_wire) 
        begin
            if(loop_cnt < TOKENS/Q_TILES - 1) 
            begin
                loop_cnt <= loop_cnt + 1;
                pingpong_mode_reg <= pingpong_mode_reg;
            end
            else 
            begin
                loop_cnt <= 0;
                pingpong_mode_reg <= ~pingpong_mode_reg;
            end
        end
        else 
        begin
            loop_cnt <= loop_cnt;
            pingpong_mode_reg <= pingpong_mode_reg;
        end
    end

    wire q_ctrl_en_wire;
    assign q_ctrl_en_wire = (v_ctrl_addr_cnt == 0) && v_mem_array_en_in;

     // =====================================================
     // V memory（单个 kv_mem_array）
     // =====================================================

    kv_mem_array #(
        .HEAD_DIM(HEAD_DIM)
    ) u_v_mem_array (
        .rst_n(rst_n),

        .axi_to_bram_clk(axi_to_bram_clk),
        .axi_data_in_bus(axi_v_data_in_bus),
        .axi_we_in_bus(axi_v_we_in_bus),
        .axi_en_in_bus(axi_v_en_in_bus),
        .axi_addr_in_bus(axi_v_addr_in_bus),

        .clk(clk),
        .ctrl_addr_in({pingpong_mode_reg, v_ctrl_addr_cnt}),
        .ctrl_en_in(v_mem_array_en_in),

        .kv_data_out_bus(v_data_out_bus),
        .kv_data_out_valid_bus(v_data_out_valid_bus)
    );

endmodule
