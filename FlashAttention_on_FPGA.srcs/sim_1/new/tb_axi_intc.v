`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/10 03:42:40
// Design Name: 
// Module Name: tb_axi_intc
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

module tb_axi_intc;

// =========================
// clock / reset
// =========================
reg s_axi_aclk;
reg s_axi_aresetn;

initial begin
    s_axi_aclk = 0;
    forever #5 s_axi_aclk = ~s_axi_aclk; // 100MHz
end

initial begin
    s_axi_aresetn = 0;
    #100;
    s_axi_aresetn = 1;
end

// =========================
// AXI Lite signals (stub simplified)
// =========================
reg  [8:0]  s_axi_awaddr;
reg         s_axi_awvalid;
wire        s_axi_awready;

reg  [31:0] s_axi_wdata;
reg  [3:0]  s_axi_wstrb;
reg         s_axi_wvalid;
wire        s_axi_wready;

wire [1:0]  s_axi_bresp;
wire        s_axi_bvalid;
reg         s_axi_bready;

reg  [8:0]  s_axi_araddr;
reg         s_axi_arvalid;
wire        s_axi_arready;

wire [31:0] s_axi_rdata;
wire [1:0]  s_axi_rresp;
wire        s_axi_rvalid;
reg         s_axi_rready;

// =========================
// interrupt inputs/outputs
// =========================
reg  [2:0] intr;
wire       irq;

// =========================
// DUT
// =========================
axi_intc_0 dut (
    .s_axi_aclk(s_axi_aclk),
    .s_axi_aresetn(s_axi_aresetn),

    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),

    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),

    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),

    .s_axi_araddr(s_axi_araddr),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),

    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),

    .intr(intr),
    .irq(irq)
);

// =========================
// AXI write task (simplified)
// =========================
task axi_write(input [8:0] addr, input [31:0] data);
begin
    @(posedge s_axi_aclk);
    s_axi_awaddr  <= addr;
    s_axi_awvalid <= 1;
    s_axi_wdata   <= data;
    s_axi_wstrb   <= 4'hF;
    s_axi_wvalid  <= 1;
    s_axi_bready  <= 1;

    wait(s_axi_awready && s_axi_wready);
    @(posedge s_axi_aclk);

    s_axi_awvalid <= 0;
    s_axi_wvalid  <= 0;

    wait(s_axi_bvalid);
    @(posedge s_axi_aclk);

    s_axi_bready <= 0;
end
endtask


// =========================
// AXI read task (simplified)
// =========================
task axi_read;
input  [8:0] addr;
output [31:0] data;
begin
    @(posedge s_axi_aclk);

    s_axi_araddr  <= addr;
    s_axi_arvalid <= 1;
    s_axi_rready  <= 1;

    wait(s_axi_arready);

    @(posedge s_axi_aclk);
    s_axi_arvalid <= 0;

    wait(s_axi_rvalid);

    data = s_axi_rdata;

    $display("READ addr=0x%h data=0x%h time=%0t",
              addr, data, $time);

    @(posedge s_axi_aclk);
    s_axi_rready <= 0;
end
endtask

// =========================
// stimulus
// =========================
reg [31:0] pending;
initial begin
    // init
    intr = 0;
    pending = 0;

    s_axi_awvalid = 0;
    s_axi_wvalid  = 0;
    s_axi_bready   = 0;
    s_axi_arvalid  = 0;
    s_axi_rready   = 0;

    #200;

    // ==================================================
    // 1. enable interrupt (IER = 0x7)
    // ==================================================
    axi_write(9'h08, 32'h7);
    axi_write(9'h1c, 32'h3);


    // ==================================================
    // 2. trigger interrupt pulse
    // ==================================================
    #50;
    intr = 3'b001;
    #10;
    intr = 3'b011;   // ⭐必须拉低（关键）
    #10;
    intr = 3'b001;   // ⭐必须拉低（关键）

    // wait(irq); // 等待中断被触发
    // axi_read(9'h04, pending); // IPR
    // axi_write(9'h0c, 32'h1); // ⭐根据 pending 清理

    // wait(irq); // 等待中断被触发
    // axi_read(9'h04, pending); // IPR
    // axi_write(9'h0c, 32'h2); // ⭐根据 pending 清理

    #50;
    intr = 3'b001;
    #10;
    intr = 3'b011;   // ⭐必须拉低（关键）
    #10;
    intr = 3'b000;   // ⭐必须拉低（关键）

    // wait(irq); // 等待中断被触发
    axi_read(9'h04, pending); // IPR
    axi_write(9'h0c, 32'h1); // ⭐根据 pending 清理

    // wait(irq); // 等待中断被触发
    axi_read(9'h04, pending); // IPR
    axi_write(9'h0c, 32'h2); // ⭐根据 pending 清理

    axi_read(9'h04, pending); // IPR

    $finish;
end

// =========================
// monitor
// =========================
initial begin
    $monitor("t=%0t intr=%b irq=%b",
                $time, intr, irq);
end

endmodule