`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/15 21:07:06
// Design Name: 
// Module Name: tb_ws_pe
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


module tb_ws_pe;
    reg clk;
    reg rst_n;

    reg  [15:0] q_in;
    reg         q_in_valid;

    reg  [15:0] k_in;
    reg         k_in_valid;

    reg  [15:0] acc_in;
    reg         acc_in_valid;

    wire [15:0] acc_out;
    wire        acc_out_valid;

    // ----------------------------------
    // DUT
    // ----------------------------------
    reg  [15:0]  s_reg;

    

    ws_pe dut(
        .clk(clk),
        .rst_n(rst_n),

        .q_in(q_in),
        .q_in_valid(q_in_valid),

        .k_in(k_in),
        .k_in_valid(k_in_valid),

        .acc_in(acc_in),
        .acc_in_valid(acc_in_valid),

        .acc_out(acc_out),
        .acc_out_valid(acc_out_valid)
    );
    always @(posedge clk) begin
         if(acc_out_valid) s_reg <= acc_out;
    end
   
    // ----------------------------------
    // Clock generation
    // ----------------------------------

    initial begin
        clk = 1;
        forever #5 clk = ~clk;   // 100MHz
    end


    // ----------------------------------
    // Stimulus
    // ----------------------------------

    initial begin

        rst_n = 0;

        q_in = 0;
        q_in_valid = 0;

        k_in = 0;
        k_in_valid = 0;

        acc_in = 0;
        acc_in_valid = 0;

        #90;
        rst_n = 1;

        // ------------------------------
        // Test case 1
        // q * k + acc
        // ------------------------------

        q_in = 16'h3C00;      // FP16 1.0
        k_in = 16'h4000;      // FP16 2.0
        q_in_valid = 1;
        k_in_valid = 1;

        #40;
        acc_in = 16'h0000;    // FP16 0
        q_in_valid = 1;
        k_in_valid = 1;
        acc_in_valid = 1;

        // ------------------------------
        // Test case 2
        // ------------------------------

        #10;

        q_in = 16'h4000;      // 2
        k_in = 16'h4000;      // 2
        acc_in = 16'h3C00;    // 1

        q_in_valid = 1;
        k_in_valid = 1;
        acc_in_valid = 1;

        #10;

        q_in_valid = 1;
        k_in_valid = 1;
        acc_in_valid = 1;

        #10;
        q_in_valid = 0;
        k_in_valid = 0;
        acc_in_valid = 0;

        // ------------------------------

        #100;

        $finish;

    end


    // ----------------------------------
    // Monitor
    // ----------------------------------

    initial begin
        $monitor("time=%0t q=%h k=%h acc_in=%h -> acc_out=%h valid=%b",
                  $time, q_in, k_in, acc_in, acc_out, acc_out_valid);
    end


endmodule
