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


module cmp_unit (
    input  wire                     clk,
    input  wire                     rst_n,

    input  wire                     s_valid_in,
    input  wire [15:0]              s_in,
    input  wire                     s_last_in,

    output wire                     s_valid_out,
    output wire [15:0]              s_out,
    output wire                     s_last_out,

    output wire [15:0]              cmp_m_out,
    output wire                     m_valid_out
);

    reg [15:0] cmp_m_reg;
    reg [15:0] s_in_reg;
    reg        s_last_in_reg;
    reg        s_valid_in_reg;


    // ================================
    // FP16 CMP IP
    // ================================
    wire [7:0] cmp_result;
    wire       cmp_valid;


    fp16_cmp u_fp16_cmp (
        .s_axis_a_tvalid(s_valid_in),
        .s_axis_a_tdata (s_in),
        .s_axis_b_tvalid(1'b1),
        .s_axis_b_tdata (cmp_b_wire),
        .m_axis_result_tvalid(cmp_valid),
        .m_axis_result_tdata (cmp_result)
    );

    reg [15:0] cmp_b_wire;
    always @(*)
    begin
        if(!s_last_in_reg) cmp_b_wire = cmp_m_reg;
        else cmp_b_wire = 16'hFC00;  
    end


    wire a_gt_b = cmp_result[0];

    // ================================
    // input registers
    // ================================
    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n) 
        begin
            s_in_reg   <= 0;
            s_last_in_reg <= 0;
            s_valid_in_reg <= 0;
        end 
        else 
        begin
            s_in_reg   <= s_in;
            s_last_in_reg <= s_last_in;
            s_valid_in_reg <= s_valid_in;
        end
    end

    // ================================
    // max refresh logic
    // ================================
    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n) 
        begin
            // -INF（FP16）
            cmp_m_reg <= 16'hFC00;  
        end 
        else if (cmp_valid) 
        begin
            if(s_last_in_reg)
                cmp_m_reg <= s_in;
            else if (a_gt_b)
                cmp_m_reg <= s_in;
            else
                cmp_m_reg <= cmp_m_reg;

        end
    end

    // ================================
    // output
    // ================================
    assign cmp_m_out = cmp_m_reg;
    assign m_valid_out = s_last_in_reg;

    assign s_out       = s_in_reg;
    assign s_last_out  = s_last_in_reg;
    assign s_valid_out = s_valid_in_reg;

endmodule
