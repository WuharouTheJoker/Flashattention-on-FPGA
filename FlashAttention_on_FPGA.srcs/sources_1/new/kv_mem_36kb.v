`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/27 19:45:35
// Design Name: 
// Module Name: kv_mem_36kb
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


module kv_mem_36kb(
    input       rst_n,

    input       axi_to_bram_clk,
    input[15:0] axi_data_in,
    input       axi_we_in,
    input       axi_en_in,
    input[10:0] axi_addr_in,

    input        clk,
    input[10:0]  ctrl_addr_in,
    input        ctrl_en_in,
    
    output[10:0] ctrl_addr_out,
    output       ctrl_en_out,
    
    output[15:0] kv_data_out,
    output       kv_data_out_valid
    );

    bram_36kb_mem kv_mem (
        .clka(axi_to_bram_clk),    // input wire clka
        .ena(axi_en_in),      // input wire ena
        .wea(axi_we_in),      // input wire [0 : 0] wea
        .addra(axi_addr_in),  // input wire [10 : 0] addra
        .dina(axi_data_in),    // input wire [15 : 0] dina
        .clkb(clk),    // input wire clkb
        .enb(ctrl_en_in||ctrl_en_reg1),      // input wire enb
        .addrb(ctrl_addr_in),  // input wire [10 : 0] addrb
        .doutb(kv_data_out)  // output wire [15 : 0] doutb
    );

    reg [10:0] ctrl_addr_reg;
    reg        ctrl_en_reg1;
    reg        ctrl_en_reg2;

    always@(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            ctrl_addr_reg <= 0;
            ctrl_en_reg1 <= 0;
            ctrl_en_reg2 <= 0;
        end 
        else 
        begin
            ctrl_addr_reg <= ctrl_addr_in; 
            ctrl_en_reg1 <= ctrl_en_in;
            ctrl_en_reg2 <= ctrl_en_reg1;
        end
    end

    assign ctrl_addr_out = ctrl_addr_reg;
    assign ctrl_en_out = ctrl_en_reg1;
    assign kv_data_out_valid = ctrl_en_reg2; 

endmodule
