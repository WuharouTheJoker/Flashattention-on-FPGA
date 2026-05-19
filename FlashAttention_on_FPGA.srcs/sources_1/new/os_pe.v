`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/02 17:10:14
// Design Name: 
// Module Name: os_pe
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


module os_pe(
    input              clk,
    input              rst_n,

    input      [15:0]  p_in,
    input              p_in_valid,    
    input              p_last_in,           


    input      [15:0]  v_in,
    input              v_in_valid,

    input      [15:0]  o_result_in,
    input              o_result_in_valid,

    output     [15:0]  p_out,
    output             p_out_valid,
    output             p_last_out,
    
    // output     [15:0]  o_out,
    // output             o_out_valid,

    output     [15:0]  o_result_out,
    output             o_result_out_valid

);



    // -----------------------------
    // FP16 Multiply signals
    // -----------------------------
    wire [15:0] mul_result;
    wire        mul_valid;

    // -----------------------------
    // FP16 Multiplier IP
    // -----------------------------

    fp16_multiply mul_inst (
        .aclk                (clk),

        .s_axis_a_tvalid     (p_in_valid),
        .s_axis_a_tdata      (p_in),

        .s_axis_b_tvalid     (v_in_valid),
        .s_axis_b_tdata      (v_in),

        .m_axis_result_tvalid(mul_valid),
        .m_axis_result_tdata (mul_result)
    );

    // -----------------------------
    // FP16 Adder IP
    // -----------------------------

    wire add_valid;
    wire [15:0] add_out;

    fp16_add add_inst (
        .aclk                (clk),

        .s_axis_a_tvalid     (mul_valid),
        .s_axis_a_tdata      (mul_result),

        .s_axis_b_tvalid     (mul_valid),
        .s_axis_b_tdata      (add_b_wire),

        .m_axis_result_tvalid(add_valid),
        .m_axis_result_tdata (add_out)
    );


    reg[15:0] add_b_wire;

    reg p_last_reg1;
    reg p_last_reg2;
    reg p_last_reg3;
    reg p_last_reg4;


    always @(*)    
    begin
        if(p_last_reg4||!add_valid) add_b_wire = 16'h0000;  // new s row
        else if(add_valid) add_b_wire = add_out;  // old sum
    end

    reg[15:0] p_out_reg;
    reg p_out_valid_reg;
    reg p_last_out_reg;

    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n)
        begin
            p_last_reg1 <= 1'b0;
            p_last_reg2 <= 1'b0;
            p_last_reg3 <= 1'b0;
            p_last_reg4 <= 1'b0;
            p_out_reg <= 16'h0000;
            p_out_valid_reg <= 1'b0;
            p_last_out_reg <= 1'b0;
        end
        else
        begin

            p_out_reg <= p_in;
            p_out_valid_reg <= p_in_valid;
            p_last_out_reg <= p_last_in;
            p_last_reg1 <= p_last_in;
            p_last_reg2 <= p_last_reg1;
            p_last_reg3 <= p_last_reg2;
            p_last_reg4 <= p_last_reg3;

        end
    end

    assign p_out = p_out_reg;
    assign p_out_valid = p_out_valid_reg;
    assign p_last_out = p_last_out_reg;

    // assign o_out = add_out;
    // assign o_out_valid = p_last_reg4;


    reg[15:0] o_result_reg;
    reg       o_result_valid_reg;

    always @(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            o_result_reg <= 16'h0000;
            o_result_valid_reg <= 1'b0;
        end
        else if(p_last_reg4) 
        begin
            o_result_reg <= add_out;
            o_result_valid_reg <= 1'b1;
        end
        else if(o_result_in_valid) 
        begin
            o_result_reg <= o_result_in;
            o_result_valid_reg <= 1'b1;
        end
        else 
        begin
            o_result_valid_reg <= 1'b0;
        end
    end

    assign o_result_out = o_result_reg;
    assign o_result_out_valid = o_result_valid_reg;

endmodule
