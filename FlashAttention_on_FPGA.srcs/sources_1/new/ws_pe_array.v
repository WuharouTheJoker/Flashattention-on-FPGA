`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/15 22:40:52
// Design Name: 
// Module Name: ws_pe_array_4
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

module ws_pe_array #(
    parameter HEAD_DIM = 4,
    parameter TOKENS = 8,
    parameter inv_sqrt_head_dim = 16'h3800// 1/sqrt(4) = 0.5, fp16 = 16'h3800
)(
    input clk,
    input rst_n,

    input  [HEAD_DIM*16-1:0]  q_in_bus ,
    input  [HEAD_DIM-1:0]     q_in_valid_bus,

    input  [HEAD_DIM*16-1:0]  k_in_bus,
    input  [HEAD_DIM-1:0]     k_in_valid_bus,

    output [15:0]           s_out,
    output                  s_out_valid,
    output                  s_last_out
);

    // ---------------------------------
    // Internal wires
    // ---------------------------------

    wire [15:0] acc_data  [HEAD_DIM-1:0];
    wire        acc_valid [HEAD_DIM-1:0];


    // ---------------------------------
    // Bottom PE
    // ---------------------------------

    bottom_ws_pe pe0 (

        .clk(clk),
        .rst_n(rst_n),

        .q_in(q_in_bus[15:0]),
        .q_in_valid(q_in_valid_bus[0]),

        .k_in(k_in_bus[15:0]),
        .k_in_valid(k_in_valid_bus[0]),

        .up_out(acc_data[0]),
        .up_out_valid(acc_valid[0])
    );


    // ---------------------------------
    // Remaining PE
    // ---------------------------------

    genvar i;

    generate
        for(i = 1; i < HEAD_DIM; i = i + 1)
        begin : WS_PE_ARRAY

            ws_pe pe_inst (
                .clk(clk),
                .rst_n(rst_n),

                .q_in(q_in_bus[(i+1)*16-1:i*16]),
                .q_in_valid(q_in_valid_bus[i]),

                .k_in(k_in_bus[(i+1)*16-1:i*16]),
                .k_in_valid(k_in_valid_bus[i]),

                .acc_in(acc_data[i-1]),
                .acc_in_valid(acc_valid[i-1]),

                .acc_out(acc_data[i]),
                .acc_out_valid(acc_valid[i])
            );

        end
    endgenerate

    wire [15:0]  scaled_s_out;
    wire         scaled_s_out_valid;

    fp16_multiply scale_inst (
    .aclk(clk),                                 
    .s_axis_a_tvalid(acc_valid[HEAD_DIM-1]),           
    .s_axis_a_tdata(acc_data[HEAD_DIM-1]),              
    .s_axis_b_tvalid(1'b1),           
    .s_axis_b_tdata(inv_sqrt_head_dim),              
    .m_axis_result_tvalid(scaled_s_out_valid), 
    .m_axis_result_tdata(scaled_s_out)    
    );


    reg[9:0] count;
    reg      s_last_out_reg;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            count <= 0;
            s_last_out_reg <= 0;
        end 
        else if(scaled_s_out_valid) 
        begin
            if(count == TOKENS-1) 
            begin
                count <= 0;
            end
            else 
            begin
                count <= count + 1;
            end
           
        end
    end

    assign s_out = scaled_s_out;
    assign s_out_valid = scaled_s_out_valid;
    assign s_last_out = (count == TOKENS-1) && scaled_s_out_valid;

endmodule