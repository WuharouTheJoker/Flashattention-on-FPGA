`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/02 17:10:43
// Design Name: 
// Module Name: ws_pe
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


module ws_pe(
    input              clk,
    input              rst_n,

    input      [15:0]  q_in,
    input              q_in_valid,    

    input      [15:0]  k_in,
    input              k_in_valid,

    input      [15:0]  acc_in,
    input              acc_in_valid,
    

    output     [15:0]  acc_out,
    output             acc_out_valid

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

        .s_axis_a_tvalid     (q_valid_wire),
        .s_axis_a_tdata      (q_data_wire),

        .s_axis_b_tvalid     (k_in_valid),
        .s_axis_b_tdata      (k_in),

        .m_axis_result_tvalid(mul_valid),
        .m_axis_result_tdata (mul_result)
    );

    // -----------------------------
    // FP16 Adder IP
    // -----------------------------

    fp16_add add_inst (
        .aclk                (clk),

        .s_axis_a_tvalid     (mul_valid),
        .s_axis_a_tdata      (mul_result),

        .s_axis_b_tvalid     (acc_in_valid),
        .s_axis_b_tdata      (acc_in),

        .m_axis_result_tvalid(acc_out_valid),
        .m_axis_result_tdata (acc_out)
    );

    // -----------------------------
    // Output register
    // -----------------------------

    reg q_valid_reg;
    reg [15:0] q_reg;

    reg [15:0] q_data_wire ;
    reg        q_valid_wire ;

    always @(*)
    begin
        if(!q_in_valid)
        begin
            q_data_wire = q_reg;
            q_valid_wire = q_valid_reg;
        end
        else
        begin
            q_data_wire = q_in;
            q_valid_wire = q_in_valid;
        end 
    end


    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n)
        begin
            q_valid_reg <= 1'b0;
            q_reg <= 16'b0;
        end
        else
        begin
            if(q_in_valid)
            begin
                q_valid_reg <= q_in_valid;
                q_reg <= q_in;
            end
        end
        
    end

    
    
endmodule
