`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/15 14:38:30
// Design Name: 
// Module Name: tb_top_module_128
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

module tb_top_module_128;

parameter TOKENS        = 1024;
parameter HEAD_DIM      = 128;
parameter TOTAL_TOKENS  = 2048;

localparam Q_BASE = 16'h0000;
localparam K_BASE = 16'h4000;
localparam V_BASE = 16'h8000;

localparam KV_MEM_HALF = 1024;
localparam Q_MEM_HALF  = 512;

//======================================================
// clk rst
//======================================================

reg clk;
reg global_rst_n;

initial clk = 0;
always #1 clk = ~clk;

initial begin
    global_rst_n = 0;
    #10;
    global_rst_n = 1;
end

//======================================================
// AXI QKV
//======================================================

wire s_axi_qkv_aclk     = clk;
wire s_axi_qkv_aresetn  = global_rst_n;

reg  [20:0] s_axi_qkv_awaddr;
reg         s_axi_qkv_awvalid;
wire        s_axi_qkv_awready;

reg  [127:0] s_axi_qkv_wdata;
reg  [15:0]  s_axi_qkv_wstrb;
reg          s_axi_qkv_wvalid;
reg          s_axi_qkv_wlast;
wire         s_axi_qkv_wready;

wire [1:0] s_axi_qkv_bresp;
wire       s_axi_qkv_bvalid;
reg        s_axi_qkv_bready;

// 固定参数

wire [7:0] s_axi_qkv_awlen   = 0;
wire [2:0] s_axi_qkv_awsize  = 3'b100; // 16 bytes
wire [1:0] s_axi_qkv_awburst = 2'b01;

wire       s_axi_qkv_awlock  = 0;
wire [3:0] s_axi_qkv_awcache = 0;
wire [2:0] s_axi_qkv_awprot  = 0;

//======================================================
// DUT
//======================================================

head_dim_128_top_module #(
    .TOKENS(TOKENS)
) dut (

    .s_axi_qkv_aclk(s_axi_qkv_aclk),
    .s_axi_qkv_aresetn(s_axi_qkv_aresetn),

    .s_axi_qkv_awaddr(s_axi_qkv_awaddr),
    .s_axi_qkv_awlen(s_axi_qkv_awlen),
    .s_axi_qkv_awsize(s_axi_qkv_awsize),
    .s_axi_qkv_awburst(s_axi_qkv_awburst),
    .s_axi_qkv_awlock(s_axi_qkv_awlock),
    .s_axi_qkv_awcache(s_axi_qkv_awcache),
    .s_axi_qkv_awprot(s_axi_qkv_awprot),
    .s_axi_qkv_awvalid(s_axi_qkv_awvalid),
    .s_axi_qkv_awready(s_axi_qkv_awready),

    .s_axi_qkv_wdata(s_axi_qkv_wdata),
    .s_axi_qkv_wstrb(s_axi_qkv_wstrb),
    .s_axi_qkv_wlast(s_axi_qkv_wlast),
    .s_axi_qkv_wvalid(s_axi_qkv_wvalid),
    .s_axi_qkv_wready(s_axi_qkv_wready),

    .s_axi_qkv_bresp(s_axi_qkv_bresp),
    .s_axi_qkv_bvalid(s_axi_qkv_bvalid),
    .s_axi_qkv_bready(s_axi_qkv_bready),

    // 其他接口全部tie off

    .s_axi_qkv_araddr(0),
    .s_axi_qkv_arlen(0),
    .s_axi_qkv_arsize(0),
    .s_axi_qkv_arburst(0),
    .s_axi_qkv_arlock(0),
    .s_axi_qkv_arcache(0),
    .s_axi_qkv_arprot(0),
    .s_axi_qkv_arvalid(0),
    .s_axi_qkv_arready(),

    .s_axi_qkv_rdata(),
    .s_axi_qkv_rresp(),
    .s_axi_qkv_rlast(),
    .s_axi_qkv_rvalid(),
    .s_axi_qkv_rready(1),

    .clk(clk)
);

//======================================================
// AXI WRITE TASK
//======================================================

task axi_write_128;
    input [20:0] addr;
    input [127:0] data;

begin

    @(posedge s_axi_qkv_aclk);

    // AW
    s_axi_qkv_awaddr  <= addr;
    s_axi_qkv_awvalid <= 1;

    wait(s_axi_qkv_awready);

    @(posedge s_axi_qkv_aclk);

    s_axi_qkv_awvalid <= 0;

    // W
    s_axi_qkv_wdata  <= data;
    s_axi_qkv_wstrb  <= 16'hFFFF;
    s_axi_qkv_wvalid <= 1;
    s_axi_qkv_wlast  <= 1;

    wait(s_axi_qkv_wready);

    @(posedge s_axi_qkv_aclk);

    s_axi_qkv_wvalid <= 0;

    // B
    s_axi_qkv_bready <= 1;

    wait(s_axi_qkv_bvalid);

    @(posedge s_axi_qkv_aclk);

    s_axi_qkv_bready <= 0;

end
endtask

//======================================================
// QKV WRITE
//======================================================

task write_qkv_128;

    input integer batch_id;
    input integer pingpong_mode;

    integer token;
    integer dim;

    integer q_addr;
    integer k_addr;
    integer v_addr;

    reg [127:0] dummy_data;

begin

    for(token = 0; token < TOKENS; token = token + 1) begin

        for(dim = 0; dim < HEAD_DIM; dim = dim + 8) begin

            //==================================================
            // dummy data
            //==================================================

            dummy_data = {
                token[15:0],
                dim[15:0],
                16'h1111,
                16'h2222,
                16'h3333,
                16'h4444,
                16'h5555,
                16'h6666
            };

            //==================================================
            // 地址（16B aligned）
            //==================================================

            q_addr =
                Q_BASE
                + (pingpong_mode ? Q_MEM_HALF : 0) * HEAD_DIM * 2
                + ((token * HEAD_DIM + dim) * 2);

            k_addr =
                K_BASE
                + (pingpong_mode ? KV_MEM_HALF : 0) * HEAD_DIM * 2
                + ((token * HEAD_DIM + dim) * 2);

            v_addr =
                V_BASE
                + (pingpong_mode ? KV_MEM_HALF : 0) * HEAD_DIM * 2
                + ((token * HEAD_DIM + dim) * 2);

            //==================================================
            // 强制低4bit为0
            //==================================================

            q_addr = {q_addr[15:4],4'b0};
            k_addr = {k_addr[15:4],4'b0};
            v_addr = {v_addr[15:4],4'b0};

            //==================================================
            // write
            //==================================================

            axi_write_128(q_addr, dummy_data);
            axi_write_128(k_addr, dummy_data);
            axi_write_128(v_addr, dummy_data);

        end
    end

end
endtask

//======================================================
// MAIN
//======================================================

initial begin

    s_axi_qkv_awaddr  = 0;
    s_axi_qkv_awvalid = 0;

    s_axi_qkv_wdata   = 0;
    s_axi_qkv_wstrb   = 0;
    s_axi_qkv_wvalid  = 0;
    s_axi_qkv_wlast   = 0;

    s_axi_qkv_bready  = 0;

    wait(global_rst_n);

    $display("START WRITE TEST");

    for(integer addr = 2048*16*16*2; addr < 2048*16*4*16; addr = addr + 16) begin
        axi_write_128(addr, {4{addr}});
    end

    $display("WRITE TEST DONE");

    #1000;

    $stop;

end

endmodule
