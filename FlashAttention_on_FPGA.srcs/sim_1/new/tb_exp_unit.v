`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/17 17:20:47
// Design Name: 
// Module Name: tb_exp_unit
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

`timescale 1ns/1ps

module tb_exp_unit;

    reg clk;
    reg rst_n;

    reg         s_valid_in;
    reg [15:0]  s_in;
    reg         s_last_in;

    reg [15:0]  exp_m_in;
    reg         m_valid_in;

    wire        p_valid_out;
    wire        p_last_out;
    wire [15:0] p_out;

    wire        r_valid_out;
    wire [15:0] r_out;

    // DUT
    exp_unit dut (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid_in(s_valid_in),
        .s_in(s_in),
        .s_last_in(s_last_in),

        .exp_m_in(exp_m_in),
        .m_valid_in(m_valid_in),

        .p_valid_out(p_valid_out),
        .p_last_out(p_last_out),
        .p_out(p_out),

        .r_valid_out(r_valid_out),
        .r_out(r_out)
    );

    // clock
    initial clk = 1;
    always #5 clk = ~clk;

    // 数据
    reg [15:0] data_mem [0:15];

    initial begin
        // frame1
        data_mem[0] = 16'h3C00;
        data_mem[1] = 16'h4000;
        data_mem[2] = 16'h4200;
        data_mem[3] = 16'h4400;
        data_mem[4] = 16'h3C00;
        data_mem[5] = 16'h4000;
        data_mem[6] = 16'h4200;
        data_mem[7] = 16'h4400;

        // frame2
        data_mem[8]  = 16'h3800;
        data_mem[9]  = 16'h3C00;
        data_mem[10] = 16'h4000;
        data_mem[11] = 16'h4200;
        data_mem[12] = 16'h3800;
        data_mem[13] = 16'h3C00;
        data_mem[14] = 16'h4000;
        data_mem[15] = 16'h4200;
    end

    integer i;

    initial begin
        rst_n = 0;
        s_valid_in = 0;
        s_last_in  = 0;
        m_valid_in = 0;
        s_in = 0;
        exp_m_in = 0;

        #100;
       

        for (i = 0; i < 16; i = i + 1) 
        begin 
            @(posedge clk);
            rst_n <= 1;
            s_valid_in <= 1;
            s_in       <= data_mem[i];

            // 每帧最后一个
            s_last_in <= (i == 7 || i == 15);

            // 第1拍、第9拍送 m
            if (i == 0) begin
                exp_m_in  <= 16'h4400;
                m_valid_in <= 1;
            end
            else if (i == 8) begin
                exp_m_in  <= 16'h4200;
                m_valid_in <= 1;
            end
            else begin
                m_valid_in <= 0;
            end
        end

        @(posedge clk);
        s_valid_in <= 0;
        s_last_in  <= 0;
        m_valid_in <= 0;

        #300;
        $finish;
    end

    // monitor
    always @(posedge clk) begin
        if (p_valid_out)
            $display("EXP = %h, last = %b", p_out, p_last_out);

        if (r_valid_out)
            $display("SUM = %h (frame end)", r_out);
    end

endmodule