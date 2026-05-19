`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/17 16:56:37
// Design Name: 
// Module Name: cmp_unit
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

module exp_unit (
    input  wire                     clk,
    input  wire                     rst_n,

    input  wire                     s_valid_in,
    input  wire [15:0]              s_in,
    input  wire                     s_last_in,

    input  wire [15:0]              exp_m_in,
    input  wire                     m_valid_in,

    output wire                     p_valid_out,
    output wire                     p_last_out,
    output wire [15:0]              p_out,

    output wire                     r_valid_out,
    output wire [15:0]              r_out

);

 // =========================
    // Stage1: FP16 SUB
    // =========================
    wire [15:0] sub_out;
    wire        sub_valid;

    fp16_sub u_sub (
        .aclk(clk),
        .s_axis_a_tvalid(s_valid_in),
        .s_axis_a_tdata (s_in),
        .s_axis_b_tvalid(s_valid_in),
        .s_axis_b_tdata (exp_m_reg),
        .m_axis_result_tvalid(sub_valid),
        .m_axis_result_tdata (sub_out)
    );

    // reg[15:0] exp_m_wire;
    // always @(*)    
    // begin
    //     if(m_valid_in) exp_m_wire = exp_m_in;  // new s row max
    //     else exp_m_wire = exp_m_reg;  // old s row max
    // end
    
    // =========================
    // Stage2: FP16 EXP
    // =========================
    wire [15:0] exp_out;
    wire        exp_valid;

    fp16_exp u_exp (
        .aclk(clk),
        .s_axis_a_tvalid(sub_valid),
        .s_axis_a_tdata (sub_out),
        .m_axis_result_tvalid(exp_valid),
        .m_axis_result_tdata (exp_out)
    );

    // =========================
    // Stage3: Σexp
    // =========================

    wire [15:0] add_out;
    wire        add_valid;

    fp16_add u_add (
        .aclk(clk),
        .s_axis_a_tvalid(exp_valid),
        .s_axis_a_tdata (exp_out),
        .s_axis_b_tvalid(exp_valid),
        .s_axis_b_tdata (add_b_wire),
        .m_axis_result_tvalid(add_valid),
        .m_axis_result_tdata (add_out)
    );

    reg[15:0] add_b_wire;

    always @(*)    
    begin
        if(s_last_reg9||!add_valid) add_b_wire = 16'h0000;  // new s row
        else if(add_valid) add_b_wire = add_out;  // old sum
    end

    reg s_last_reg1;
    reg s_last_reg2;
    reg s_last_reg3;
    reg s_last_reg4;
    reg s_last_reg5;
    reg s_last_reg6;
    reg s_last_reg7;
    reg s_last_reg8;
    reg s_last_reg9;

    reg [15:0] exp_m_reg;

    // running sum 核心逻辑
    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n)
        begin
            exp_m_reg <= 16'h0000;
            s_last_reg1 <= 0;
            s_last_reg2 <= 0;
            s_last_reg3 <= 0;
            s_last_reg4 <= 0;
            s_last_reg5 <= 0;
            s_last_reg6 <= 0;
            s_last_reg7 <= 0;
            s_last_reg8 <= 0;
            s_last_reg9 <= 0;
        end
        else 
        begin
            s_last_reg1 <= s_last_in;
            s_last_reg2 <= s_last_reg1;
            s_last_reg3 <= s_last_reg2;
            s_last_reg4 <= s_last_reg3;
            s_last_reg5 <= s_last_reg4;
            s_last_reg6 <= s_last_reg5;
            s_last_reg7 <= s_last_reg6;
            s_last_reg8 <= s_last_reg7;
            s_last_reg9 <= s_last_reg8;

            if (m_valid_in) exp_m_reg <= exp_m_in;  // refresh s row max
            else exp_m_reg <= exp_m_reg;

        end
    end

    // =========================
    // output
    // =========================
    assign p_out         = exp_out;
    assign p_valid_out   = exp_valid;
    assign p_last_out    = s_last_reg8;

    assign r_out         = add_out;
    assign r_valid_out   = s_last_reg9;


endmodule