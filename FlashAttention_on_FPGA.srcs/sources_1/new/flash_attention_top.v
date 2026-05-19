`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/19 23:38:25
// Design Name: 
// Module Name: flash_attention_top
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

module flashattention_top #(
    parameter HEAD_DIM = 128,
    parameter TOKENS   = 1024
)(
    input clk,
    input rst_n,

    // 为简单起见，这里给每个单元独立输入（避免被优化）
    input  [4*HEAD_DIM*16-1:0]  q_in_bus_all,
    input  [4*HEAD_DIM-1:0]     q_in_valid_all,

    input  [4*HEAD_DIM*16-1:0]  k_in_bus_all,
    input  [4*HEAD_DIM-1:0]     k_in_valid_all,

    input  [4*HEAD_DIM*16-1:0]  v_in_bus_all,
    input  [4*HEAD_DIM-1:0]     v_in_valid_all,

    output [4*HEAD_DIM*16-1:0]  o_out_bus_all,
    output [4*HEAD_DIM-1:0]     o_out_valid_all
);

    genvar i;

    generate
        for(i = 0; i < 4; i = i + 1) begin : FA_UNITS

            // -----------------------------
            // 输入切片
            // -----------------------------
            wire [HEAD_DIM*16-1:0] q_in_bus;
            wire [HEAD_DIM-1:0]    q_in_valid;

            wire [HEAD_DIM*16-1:0] k_in_bus;
            wire [HEAD_DIM-1:0]    k_in_valid;

            wire [HEAD_DIM*16-1:0] v_in_bus;
            wire [HEAD_DIM-1:0]    v_in_valid;

            assign q_in_bus   = q_in_bus_all[i*HEAD_DIM*16 +: HEAD_DIM*16];
            assign q_in_valid = q_in_valid_all[i*HEAD_DIM +: HEAD_DIM];

            assign k_in_bus   = k_in_bus_all[i*HEAD_DIM*16 +: HEAD_DIM*16];
            assign k_in_valid = k_in_valid_all[i*HEAD_DIM +: HEAD_DIM];

            assign v_in_bus   = v_in_bus_all[i*HEAD_DIM*16 +: HEAD_DIM*16];
            assign v_in_valid = v_in_valid_all[i*HEAD_DIM +: HEAD_DIM];

            // -----------------------------
            // 输出
            // -----------------------------
            wire [HEAD_DIM*16-1:0] o_out_bus;
            wire [HEAD_DIM-1:0]    o_out_valid;

            wire r_valid_out;
            wire [15:0] r_out;

            wire m_valid_out;
            wire [15:0] m_out;

            // -----------------------------
            // 实例化你的模块
            // -----------------------------
            streaming_flashattention_unit u_flashattention (
                .clk(clk),
                .rst_n(rst_n),

                .q_in_bus(q_in_bus),
                .q_in_valid_bus(q_in_valid),

                .k_in_bus(k_in_bus),
                .k_in_valid_bus(k_in_valid),

                .v_in_bus(v_in_bus),
                .v_in_valid_bus(v_in_valid),

                .r_valid_out(r_valid_out),
                .r_out(r_out),

                .m_valid_out(m_valid_out),
                .m_out(m_out),

                .o_out_bus(o_out_bus),
                .o_out_valid_bus(o_out_valid)
            );

            // -----------------------------
            // 输出拼接（关键：防止优化）
            // -----------------------------
            assign o_out_bus_all[i*HEAD_DIM*16 +: HEAD_DIM*16] = o_out_bus;
            assign o_out_valid_all[i*HEAD_DIM +: HEAD_DIM]     = o_out_valid;

        end
    endgenerate

endmodule
