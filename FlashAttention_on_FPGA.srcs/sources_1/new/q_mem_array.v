`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/30 15:00:34
// Design Name: 
// Module Name: q_mem_array
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


module q_mem_array#(
    parameter HEAD_DIM = 4
)(
    input                   rst_n,

    input                   axi_to_bram_clk,
    input [HEAD_DIM*16-1:0] axi_data_in_bus,
    input [HEAD_DIM-1:0]    axi_we_in_bus,
    input [HEAD_DIM-1:0]    axi_en_in_bus,
    input [10*HEAD_DIM-1:0] axi_addr_in_bus,

    input                   clk,
    input [9:0]             ctrl_addr_in,
    input                   ctrl_en_in,
    
    output [HEAD_DIM*16-1:0] q_data_out_bus,
    output [HEAD_DIM-1:0]    q_data_out_valid_bus
);

    // ============================
    // ctrl 链
    // ============================
    wire [9:0] ctrl_addr_chain [0:HEAD_DIM];
    wire        ctrl_en_chain   [0:HEAD_DIM];

    assign ctrl_addr_chain[0] = ctrl_addr_in;
    assign ctrl_en_chain[0]   = ctrl_en_in;

    genvar i;
    generate
        for(i = 0; i < HEAD_DIM; i = i + 1) begin : Q_MEM_GEN

            q_mem_18kb u_q_mem (
                .rst_n(rst_n),

                // AXI 写
                .axi_to_bram_clk(axi_to_bram_clk),
                .axi_data_in(axi_data_in_bus[i*16 +: 16]),
                .axi_we_in(axi_we_in_bus[i]),
                .axi_en_in(axi_en_in_bus[i]),
                .axi_addr_in(axi_addr_in_bus[i*10 +: 10]),

                // ctrl 读
                .clk(clk),
                .ctrl_addr_in(ctrl_addr_chain[i]),
                .ctrl_en_in(ctrl_en_chain[i]),

                // ctrl 链传递
                .ctrl_addr_out(ctrl_addr_chain[i+1]),
                .ctrl_en_out(ctrl_en_chain[i+1]),

                // 输出
                .q_data_out(q_data_out_bus[i*16 +: 16]),
                .q_data_out_valid(q_data_out_valid_bus[i])
            );

        end
    endgenerate

endmodule
