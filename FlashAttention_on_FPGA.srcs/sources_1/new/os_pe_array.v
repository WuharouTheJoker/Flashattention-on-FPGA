`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/19 04:57:18
// Design Name: 
// Module Name: os_pe_array
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


module os_pe_array #(
    parameter HEAD_DIM = 4
)(
    input clk,
    input rst_n,

    input  [15:0]             p_in,
    input                     p_in_valid,
    input                     p_last_in,

    input  [HEAD_DIM*16-1:0]  v_in_bus,
    input  [HEAD_DIM-1:0]     v_in_valid_bus,

    // output [HEAD_DIM*16-1:0]  o_out_bus,
    // output [HEAD_DIM-1:0]     o_out_valid_bus,

    output [15:0]             o_result_out,
    output                    o_result_out_valid
);

    

    wire [15:0] p_data_wire  [HEAD_DIM-1:0];
    wire        p_valid_wire [HEAD_DIM-1:0];
    wire        p_last_wire  [HEAD_DIM-1:0];

    wire [15:0] o_result_out_wire [HEAD_DIM-1:0];
    wire        o_result_out_valid_wire [HEAD_DIM-1:0];

    os_pe pe0(
        .clk(clk),
        .rst_n(rst_n),

        .p_in(p_in),
        .p_in_valid(p_in_valid),
        .p_last_in(p_last_in),

        .v_in(v_in_bus[15:0]),
        .v_in_valid(v_in_valid_bus[0]),

        .p_out(p_data_wire[0]),
        .p_out_valid(p_valid_wire[0]),
        .p_last_out(p_last_wire[0]),

        // .o_out(o_out_bus[15:0]),
        // .o_out_valid(o_out_valid_bus[0]),

        .o_result_in(o_result_out_wire[0]),
        .o_result_in_valid(o_result_out_valid_wire[0]),

        .o_result_out(o_result_out),
        .o_result_out_valid(o_result_out_valid)

    );

    genvar i;

    generate
        for(i = 1; i < HEAD_DIM; i = i + 1)
        begin : OS_PE_ARRAY

            os_pe pe_inst (
                .clk(clk),
                .rst_n(rst_n),

                .p_in(p_data_wire[i-1]),
                .p_in_valid(p_valid_wire[i-1]),
                .p_last_in(p_last_wire[i-1]),

                .v_in(v_in_bus[(i+1)*16-1:i*16]),
                .v_in_valid(v_in_valid_bus[i]),

                .p_out(p_data_wire[i]),
                .p_out_valid(p_valid_wire[i]),
                .p_last_out(p_last_wire[i]),

                // .o_out(o_out_bus[(i+1)*16-1:i*16]),
                // .o_out_valid(o_out_valid_bus[i]),

                .o_result_in(o_result_out_wire[i]),
                .o_result_in_valid(o_result_out_valid_wire[i]),

                .o_result_out(o_result_out_wire[i-1]),
                .o_result_out_valid(o_result_out_valid_wire[i-1])
            );

        end
    endgenerate

    assign o_result_out_wire[HEAD_DIM-1] = 16'b0;
    assign o_result_out_valid_wire[HEAD_DIM-1] = 1'b0;


endmodule