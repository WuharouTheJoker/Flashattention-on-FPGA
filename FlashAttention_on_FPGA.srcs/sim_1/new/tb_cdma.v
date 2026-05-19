`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/10 05:20:23
// Design Name: 
// Module Name: tb_cdma
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

`timescale 1ns / 1ps

module tb_cdma;

////////////////////////////////////////////////////////////
// PARAM
////////////////////////////////////////////////////////////

localparam SRC_BASE = 32'h0000_0000;
localparam DST_BASE = 32'h0000_1000;

////////////////////////////////////////////////////////////
// CLOCK / RESET
////////////////////////////////////////////////////////////

reg m_axi_aclk;
reg s_axi_lite_aclk;
reg s_axi_lite_aresetn;

initial begin
    m_axi_aclk = 0;
    forever #5 m_axi_aclk = ~m_axi_aclk;
end

initial begin
    s_axi_lite_aclk = 0;
    forever #5 s_axi_lite_aclk = ~s_axi_lite_aclk;
end

initial begin
    s_axi_lite_aresetn = 0;
    #100;
    s_axi_lite_aresetn = 1;
end

////////////////////////////////////////////////////////////
// AXI-LITE (CDMA CONTROL)
////////////////////////////////////////////////////////////

reg         s_axi_lite_awvalid;
wire        s_axi_lite_awready;
reg  [5:0]  s_axi_lite_awaddr;

reg         s_axi_lite_wvalid;
wire        s_axi_lite_wready;
reg  [31:0] s_axi_lite_wdata;

reg         s_axi_lite_bready;
wire        s_axi_lite_bvalid;
wire [1:0]  s_axi_lite_bresp;

reg         s_axi_lite_arvalid;
wire        s_axi_lite_arready;
reg  [5:0]  s_axi_lite_araddr;

reg         s_axi_lite_rready;
wire        s_axi_lite_rvalid;
wire [31:0] s_axi_lite_rdata;
wire [1:0]  s_axi_lite_rresp;

////////////////////////////////////////////////////////////
// AXI FULL (CDMA MASTER → BRAM CTRL)
// SRC read
// DST write
////////////////////////////////////////////////////////////

wire         m_axi_arvalid;
wire [31:0]  m_axi_araddr;
wire [7:0]   m_axi_arlen;
wire [2:0]   m_axi_arsize;
wire [1:0]   m_axi_arburst;
wire [2:0]   m_axi_arprot;
wire [3:0]   m_axi_arcache;
wire         m_axi_arready;

wire         m_axi_rready;
wire         m_axi_rvalid;
wire [31:0]  m_axi_rdata;
wire [1:0]   m_axi_rresp;
wire         m_axi_rlast;

wire         m_axi_awvalid;
wire [31:0]  m_axi_awaddr;
wire [7:0]   m_axi_awlen;
wire [2:0]   m_axi_awsize;
wire [1:0]   m_axi_awburst;
wire [2:0]   m_axi_awprot;
wire [3:0]   m_axi_awcache;
wire         m_axi_awready;

wire         m_axi_wvalid;
wire [31:0]  m_axi_wdata;
wire [3:0]   m_axi_wstrb;
wire         m_axi_wlast;
wire         m_axi_wready;

wire         m_axi_bvalid;
wire [1:0]   m_axi_bresp;
wire         m_axi_bready;

////////////////////////////////////////////////////////////
// INTERRUPT
////////////////////////////////////////////////////////////

wire cdma_introut;
wire [31:0] cdma_tvect_out;

////////////////////////////////////////////////////////////
// DUT (CDMA)
////////////////////////////////////////////////////////////

axi_cdma_0 dut (
    .m_axi_aclk(m_axi_aclk),
    .s_axi_lite_aclk(s_axi_lite_aclk),
    .s_axi_lite_aresetn(s_axi_lite_aresetn),

    .cdma_introut(cdma_introut),
    .cdma_tvect_out(cdma_tvect_out),

    // AXI-LITE
    .s_axi_lite_awvalid(s_axi_lite_awvalid),
    .s_axi_lite_awready(s_axi_lite_awready),
    .s_axi_lite_awaddr(s_axi_lite_awaddr),

    .s_axi_lite_wvalid(s_axi_lite_wvalid),
    .s_axi_lite_wready(s_axi_lite_wready),
    .s_axi_lite_wdata(s_axi_lite_wdata),

    .s_axi_lite_bvalid(s_axi_lite_bvalid),
    .s_axi_lite_bready(s_axi_lite_bready),
    .s_axi_lite_bresp(s_axi_lite_bresp),

    .s_axi_lite_arvalid(s_axi_lite_arvalid),
    .s_axi_lite_arready(s_axi_lite_arready),
    .s_axi_lite_araddr(s_axi_lite_araddr),

    .s_axi_lite_rvalid(s_axi_lite_rvalid),
    .s_axi_lite_rready(s_axi_lite_rready),
    .s_axi_lite_rdata(s_axi_lite_rdata),
    .s_axi_lite_rresp(s_axi_lite_rresp),

    // AXI MASTER (CDMA)
    .m_axi_arvalid(m_axi_arvalid),
    .m_axi_araddr(m_axi_araddr),
    .m_axi_arlen(m_axi_arlen),
    .m_axi_arsize(m_axi_arsize),
    .m_axi_arburst(m_axi_arburst),
    .m_axi_arcache(m_axi_arcache),
    .m_axi_arprot(m_axi_arprot),
    .m_axi_arready(m_axi_arready),

    .m_axi_rvalid(m_axi_rvalid),
    .m_axi_rready(m_axi_rready),
    .m_axi_rdata(m_axi_rdata),
    .m_axi_rresp(m_axi_rresp),
    .m_axi_rlast(m_axi_rlast),

    .m_axi_awvalid(m_axi_awvalid),
    .m_axi_awaddr(m_axi_awaddr),
    .m_axi_awlen(m_axi_awlen),
    .m_axi_awsize(m_axi_awsize),
    .m_axi_awburst(m_axi_awburst),
    .m_axi_awcache(m_axi_awcache),
    .m_axi_awprot(m_axi_awprot),
    .m_axi_awready(m_axi_awready),

    .m_axi_wvalid(m_axi_wvalid),
    .m_axi_wdata(m_axi_wdata),
    .m_axi_wstrb(m_axi_wstrb),
    .m_axi_wlast(m_axi_wlast),
    .m_axi_wready(m_axi_wready),

    .m_axi_bvalid(m_axi_bvalid),
    .m_axi_bresp(m_axi_bresp),
    .m_axi_bready(m_axi_bready)
);
////////////////////////////////////////////////////////////
// AXI BRAM CTRL (SOURCE - READ ONLY)
////////////////////////////////////////////////////////////

axi_bram_ctrl_qkv u_src (
    .s_axi_aclk(m_axi_aclk),
    .s_axi_aresetn(s_axi_lite_aresetn),

    // WRITE CHANNEL (DISABLE)
    .s_axi_awaddr  (16'b0),
    .s_axi_awlen   (8'b0),
    .s_axi_awsize  (3'b0),
    .s_axi_awburst (2'b0),
    .s_axi_awvalid (1'b0),
    .s_axi_awready (),

    .s_axi_wdata   (32'b0),
    .s_axi_wstrb   (4'b0),
    .s_axi_wlast   (1'b0),
    .s_axi_wvalid  (1'b0),
    .s_axi_wready  (),

    .s_axi_bvalid  (),
    .s_axi_bresp   (),
    .s_axi_bready  (1'b0),

    // READ CHANNEL (ACTIVE)
    .s_axi_araddr  (m_axi_araddr[15:0]),
    .s_axi_arlen   (m_axi_arlen),
    .s_axi_arsize  (m_axi_arsize),
    .s_axi_arburst (m_axi_arburst),
    .s_axi_arvalid (m_axi_arvalid),
    .s_axi_arready (m_axi_arready),

    .s_axi_rdata   (m_axi_rdata),
    .s_axi_rresp   (m_axi_rresp),
    .s_axi_rlast   (m_axi_rlast),
    .s_axi_rvalid  (m_axi_rvalid),
    .s_axi_rready  (m_axi_rready)
);

////////////////////////////////////////////////////////////
// AXI BRAM CTRL (DEST - WRITE ONLY)
////////////////////////////////////////////////////////////

axi_bram_ctrl_qkv u_dst (
    .s_axi_aclk(m_axi_aclk),
    .s_axi_aresetn(s_axi_lite_aresetn),

    // WRITE CHANNEL (ACTIVE)
    .s_axi_awaddr  (m_axi_awaddr[15:0]),
    .s_axi_awlen   (m_axi_awlen),
    .s_axi_awsize  (m_axi_awsize),
    .s_axi_awburst (m_axi_awburst),
    .s_axi_awvalid (m_axi_awvalid),
    .s_axi_awready (m_axi_awready),

    .s_axi_wdata   (m_axi_wdata),
    .s_axi_wstrb   (m_axi_wstrb),
    .s_axi_wlast   (m_axi_wlast),
    .s_axi_wvalid  (m_axi_wvalid),
    .s_axi_wready  (m_axi_wready),

    .s_axi_bvalid  (m_axi_bvalid),
    .s_axi_bresp   (m_axi_bresp),
    .s_axi_bready  (m_axi_bready),

    // READ CHANNEL (DISABLE)
    .s_axi_araddr  (16'b0),
    .s_axi_arlen   (8'b0),
    .s_axi_arsize  (3'b0),
    .s_axi_arburst (2'b0),
    .s_axi_arvalid (1'b0),
    .s_axi_arready (),

    .s_axi_rdata   (),
    .s_axi_rresp   (),
    .s_axi_rlast   (),
    .s_axi_rvalid  (),
    .s_axi_rready  (1'b0)
);

////////////////////////////////////////////////////////////
// AXI-LITE TASK
////////////////////////////////////////////////////////////

task axi_lite_write(input [5:0] addr, input [31:0] data);
begin
    @(posedge s_axi_lite_aclk);
    s_axi_lite_awaddr  <= addr;
    s_axi_lite_awvalid <= 1;
    s_axi_lite_wdata   <= data;
    s_axi_lite_wvalid  <= 1;

    wait(s_axi_lite_awready && s_axi_lite_wready);

    @(posedge s_axi_lite_aclk);
    s_axi_lite_awvalid <= 0;
    s_axi_lite_wvalid  <= 0;

    s_axi_lite_bready  <= 1;
    wait(s_axi_lite_bvalid);
    @(posedge s_axi_lite_aclk);
    s_axi_lite_bready  <= 0;
end
endtask

task axi_read;
input  [5:0] addr;
output [31:0] data;
begin
    @(posedge s_axi_lite_aclk);

    s_axi_lite_araddr  <= addr;
    s_axi_lite_arvalid <= 1;
    s_axi_lite_rready  <= 1;

    wait(s_axi_lite_arready);

    @(posedge s_axi_lite_aclk);
    s_axi_lite_arvalid <= 0;

    wait(s_axi_lite_rvalid);

    data = s_axi_lite_rdata;

    $display("READ addr=0x%h data=0x%h time=%0t",
              addr, data, $time);

    @(posedge s_axi_lite_aclk);
    s_axi_lite_rready <= 0;
end
endtask

////////////////////////////////////////////////////////////
// TEST
////////////////////////////////////////////////////////////
reg[31:0] pending;
initial begin

    s_axi_lite_awvalid = 0;
    s_axi_lite_wvalid  = 0;
    s_axi_lite_bready  = 0;
    s_axi_lite_arvalid = 0;
    s_axi_lite_rready  = 0;

    wait(s_axi_lite_aresetn);
    #100;

    axi_read(6'h04, pending); // IPR

    $display("===== CDMA START =====");

    // enable CDMA
    axi_lite_write(6'h00, 32'h00005000);

    axi_read(6'h04, pending); // IPR

    // src
    axi_lite_write(6'h18, SRC_BASE);

    // dst
    axi_lite_write(6'h20, DST_BASE);

    // BTT = 256 bytes
    axi_lite_write(6'h28, 32'd1024);

    #2000;
    axi_read(6'h04, pending); // IPR
    $display("===== DONE, CHECK WAVE =====");

    #1000;
    $finish;

end

endmodule
