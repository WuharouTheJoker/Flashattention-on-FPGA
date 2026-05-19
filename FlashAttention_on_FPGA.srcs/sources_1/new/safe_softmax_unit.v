`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/18 23:38:18
// Design Name: 
// Module Name: safe_softmax_unit
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


module safe_softmax_unit(
    input  wire                     clk,
    input  wire                     rst_n,

    input  wire                     s_valid_in,
    input  wire [15:0]              s_in,
    input  wire                     s_last_in,

    output wire                     p_valid_out,
    output wire                     p_last_out,
    output wire [15:0]              p_out,

    output wire                     r_valid_out,
    output wire [15:0]              r_out,

    output wire                     m_valid_out,
    output wire [15:0]              m_out

    );

    wire[15:0] cmp_s_out;
    wire       cmp_s_last_out;
    wire       cmp_s_valid_out;

    wire[15:0] cmp_m_out;
    wire       cmp_m_valid_out;

    assign m_out = cmp_m_out;
    assign m_valid_out = cmp_m_valid_out;

    cmp_unit u_cmp (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid_in(s_valid_in),
        .s_in(s_in),
        .s_last_in(s_last_in),

        .s_valid_out(cmp_s_valid_out),
        .s_out(cmp_s_out),
        .s_last_out(cmp_s_last_out),

        .cmp_m_out(cmp_m_out),
        .m_valid_out(cmp_m_valid_out)
    );

    wire [15:0] exp_s_in;
    wire        exp_s_valid_in;
    wire        exp_s_last_in;

    s_buffer u_s_buffer (
    .D({cmp_s_valid_out,cmp_s_last_out,cmp_s_out}),      
    .CLK(clk),  
    .Q({exp_s_valid_in,exp_s_last_in,exp_s_in})      
    );

    exp_unit u_exp (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid_in(exp_s_valid_in),
        .s_in(exp_s_in),
        .s_last_in(exp_s_last_in),

        .exp_m_in(cmp_m_out), 
        .m_valid_in(cmp_m_valid_out),

        .p_valid_out(p_valid_out),
        .p_last_out(p_last_out),
        .p_out(p_out),

        .r_valid_out(r_valid_out),
        .r_out(r_out)
    );
endmodule
