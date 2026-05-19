`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/19 22:02:52
// Design Name: 
// Module Name: flashattention_unit
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


module streaming_matrix_mul_unit #(
        parameter HEAD_DIM = 4,
        parameter TOKENS = 8,
        parameter inv_sqrt_head_dim = 16'h3800 // 0.5
        // parameter inv_sqrt_head_dim = 16'h2da8 // 1/sqrt(128) ≈ 0.088388
    )(
        input clk,
        input rst_n,

        input  [HEAD_DIM*16-1:0]  q_in_bus ,
        input  [HEAD_DIM-1:0]     q_in_valid_bus,

        input  [HEAD_DIM*16-1:0]  k_in_bus,
        input  [HEAD_DIM-1:0]     k_in_valid_bus,

        input  [HEAD_DIM*16-1:0]  v_in_bus,
        input  [HEAD_DIM-1:0]     v_in_valid_bus,

        output              v_mem_array_en_out,
        
        output [15:0]       local_r_out,
        output              local_r_valid_out,
        
        output [15:0]       local_m_out,
        output              local_m_valid_out,

        output [15:0]       local_o_out,
        output              local_o_out_valid
    );


    wire [15:0] s_out_wire;
    wire s_out_valid_wire;
    wire s_last_out_wire;

    ws_pe_array #(
        .HEAD_DIM(HEAD_DIM),
        .TOKENS(TOKENS),
        .inv_sqrt_head_dim(inv_sqrt_head_dim)
    )ws_pe_array_dut(
        .clk(clk),
        .rst_n(rst_n),

        .q_in_bus(q_in_bus),
        .q_in_valid_bus(q_in_valid_bus),

        .k_in_bus(k_in_bus),
        .k_in_valid_bus(k_in_valid_bus),

        .s_out(s_out_wire),
        .s_out_valid(s_out_valid_wire),
        .s_last_out(s_last_out_wire)
    );

    wire p_valid_out_wire;
    wire [15:0] p_out_wire;
    wire p_last_out_wire;

    wire r_valid_out_wire;
    wire [15:0] r_out_wire;
    
    wire m_valid_out_wire;
    wire [15:0] m_out_wire;

    safe_softmax_unit uut (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid_in(s_out_valid_wire),
        .s_in(s_out_wire),
        .s_last_in(s_last_out_wire),

        .p_valid_out(p_valid_out_wire),
        .p_last_out(p_last_out_wire),
        .p_out(p_out_wire),

        .r_valid_out(local_r_valid_out),
        .r_out(local_r_out),

        .m_valid_out(local_m_valid_out),
        .m_out(local_m_out)
    );

    reg p_valid_out_reg1;
    reg p_valid_out_reg2;

    reg [15:0] p_out_reg1;
    reg [15:0] p_out_reg2;

    reg p_last_out_reg1;
    reg p_last_out_reg2;

    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)        
        begin
            p_valid_out_reg1 <= 0;
            p_valid_out_reg2 <= 0;  

            p_out_reg1 <= 0;
            p_out_reg2 <= 0;

            p_last_out_reg1 <= 0;
            p_last_out_reg2 <= 0;
        end
        else 
        begin
            p_valid_out_reg1 <= p_valid_out_wire;
            p_valid_out_reg2 <= p_valid_out_reg1;

            p_out_reg1 <= p_out_wire;
            p_out_reg2 <= p_out_reg1;

            p_last_out_reg1 <= p_last_out_wire;
            p_last_out_reg2 <= p_last_out_reg1;
        end
    end
    

    os_pe_array  #(
        .HEAD_DIM(HEAD_DIM)
    )os_pe_array_dut(
        .clk(clk),
        .rst_n(rst_n),

        .p_in(p_out_reg2),
        .p_in_valid(p_valid_out_reg2),
        .p_last_in(p_last_out_reg2),

        .v_in_bus(v_in_bus),
        .v_in_valid_bus(v_in_valid_bus),

        .o_result_out(local_o_out),
        .o_result_out_valid(local_o_out_valid)
    );

    assign v_mem_array_en_out = p_valid_out_wire;
    

endmodule
