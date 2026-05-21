// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2026 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:head_dim_4_top_module:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_head_dim_4_top_module_0_2 (
  s_axi_qkv_aclk,
  s_axi_qkv_aresetn,
  s_axi_qkv_awaddr,
  s_axi_qkv_awlen,
  s_axi_qkv_awsize,
  s_axi_qkv_awburst,
  s_axi_qkv_awlock,
  s_axi_qkv_awcache,
  s_axi_qkv_awprot,
  s_axi_qkv_awvalid,
  s_axi_qkv_awready,
  s_axi_qkv_wdata,
  s_axi_qkv_wstrb,
  s_axi_qkv_wlast,
  s_axi_qkv_wvalid,
  s_axi_qkv_wready,
  s_axi_qkv_bresp,
  s_axi_qkv_bvalid,
  s_axi_qkv_bready,
  s_axi_qkv_araddr,
  s_axi_qkv_arlen,
  s_axi_qkv_arsize,
  s_axi_qkv_arburst,
  s_axi_qkv_arlock,
  s_axi_qkv_arcache,
  s_axi_qkv_arprot,
  s_axi_qkv_arvalid,
  s_axi_qkv_arready,
  s_axi_qkv_rdata,
  s_axi_qkv_rresp,
  s_axi_qkv_rlast,
  s_axi_qkv_rvalid,
  s_axi_qkv_rready,
  s_axi_o_aclk,
  s_axi_o_aresetn,
  s_axi_o_awaddr,
  s_axi_o_awlen,
  s_axi_o_awsize,
  s_axi_o_awburst,
  s_axi_o_awlock,
  s_axi_o_awcache,
  s_axi_o_awprot,
  s_axi_o_awvalid,
  s_axi_o_awready,
  s_axi_o_wdata,
  s_axi_o_wstrb,
  s_axi_o_wlast,
  s_axi_o_wvalid,
  s_axi_o_wready,
  s_axi_o_bresp,
  s_axi_o_bvalid,
  s_axi_o_bready,
  s_axi_o_araddr,
  s_axi_o_arlen,
  s_axi_o_arsize,
  s_axi_o_arburst,
  s_axi_o_arlock,
  s_axi_o_arcache,
  s_axi_o_arprot,
  s_axi_o_arvalid,
  s_axi_o_arready,
  s_axi_o_rdata,
  s_axi_o_rresp,
  s_axi_o_rlast,
  s_axi_o_rvalid,
  s_axi_o_rready,
  s_axi_ctrl_aclk,
  s_axi_ctrl_aresetn,
  s_axi_ctrl_awaddr,
  s_axi_ctrl_awprot,
  s_axi_ctrl_awvalid,
  s_axi_ctrl_awready,
  s_axi_ctrl_wdata,
  s_axi_ctrl_wstrb,
  s_axi_ctrl_wvalid,
  s_axi_ctrl_wready,
  s_axi_ctrl_bresp,
  s_axi_ctrl_bvalid,
  s_axi_ctrl_bready,
  s_axi_ctrl_araddr,
  s_axi_ctrl_arprot,
  s_axi_ctrl_arvalid,
  s_axi_ctrl_arready,
  s_axi_ctrl_rdata,
  s_axi_ctrl_rresp,
  s_axi_ctrl_rvalid,
  s_axi_ctrl_rready,
  s_axi_intc_aclk,
  s_axi_intc_aresetn,
  s_axi_intc_awaddr,
  s_axi_intc_awvalid,
  s_axi_intc_awready,
  s_axi_intc_wdata,
  s_axi_intc_wstrb,
  s_axi_intc_wvalid,
  s_axi_intc_wready,
  s_axi_intc_bresp,
  s_axi_intc_bvalid,
  s_axi_intc_bready,
  s_axi_intc_araddr,
  s_axi_intc_arvalid,
  s_axi_intc_arready,
  s_axi_intc_rdata,
  s_axi_intc_rresp,
  s_axi_intc_rvalid,
  s_axi_intc_rready,
  irq,
  clk,
  cdma_interrupt_in,
  single_iter_done,
  all_iter_done
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_qkv_aclk, ASSOCIATED_RESET s_axi_qkv_aresetn, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_qkv_aclk CLK" *)
input wire s_axi_qkv_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_qkv_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_qkv_aresetn RST" *)
input wire s_axi_qkv_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWADDR" *)
input wire [15 : 0] s_axi_qkv_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWLEN" *)
input wire [7 : 0] s_axi_qkv_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWSIZE" *)
input wire [2 : 0] s_axi_qkv_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWBURST" *)
input wire [1 : 0] s_axi_qkv_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWLOCK" *)
input wire s_axi_qkv_awlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWCACHE" *)
input wire [3 : 0] s_axi_qkv_awcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWPROT" *)
input wire [2 : 0] s_axi_qkv_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWVALID" *)
input wire s_axi_qkv_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv AWREADY" *)
output wire s_axi_qkv_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv WDATA" *)
input wire [31 : 0] s_axi_qkv_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv WSTRB" *)
input wire [3 : 0] s_axi_qkv_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv WLAST" *)
input wire s_axi_qkv_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv WVALID" *)
input wire s_axi_qkv_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv WREADY" *)
output wire s_axi_qkv_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv BRESP" *)
output wire [1 : 0] s_axi_qkv_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv BVALID" *)
output wire s_axi_qkv_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv BREADY" *)
input wire s_axi_qkv_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARADDR" *)
input wire [15 : 0] s_axi_qkv_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARLEN" *)
input wire [7 : 0] s_axi_qkv_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARSIZE" *)
input wire [2 : 0] s_axi_qkv_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARBURST" *)
input wire [1 : 0] s_axi_qkv_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARLOCK" *)
input wire s_axi_qkv_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARCACHE" *)
input wire [3 : 0] s_axi_qkv_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARPROT" *)
input wire [2 : 0] s_axi_qkv_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARVALID" *)
input wire s_axi_qkv_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv ARREADY" *)
output wire s_axi_qkv_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv RDATA" *)
output wire [31 : 0] s_axi_qkv_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv RRESP" *)
output wire [1 : 0] s_axi_qkv_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv RLAST" *)
output wire s_axi_qkv_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv RVALID" *)
output wire s_axi_qkv_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_qkv, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 149985016, ID_WIDTH 0, ADDR_WIDTH 16, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, \
NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_qkv RREADY" *)
input wire s_axi_qkv_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_o_aclk, ASSOCIATED_RESET s_axi_o_aresetn, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_o_aclk CLK" *)
input wire s_axi_o_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_o_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_o_aresetn RST" *)
input wire s_axi_o_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWADDR" *)
input wire [17 : 0] s_axi_o_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWLEN" *)
input wire [7 : 0] s_axi_o_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWSIZE" *)
input wire [2 : 0] s_axi_o_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWBURST" *)
input wire [1 : 0] s_axi_o_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWLOCK" *)
input wire s_axi_o_awlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWCACHE" *)
input wire [3 : 0] s_axi_o_awcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWPROT" *)
input wire [2 : 0] s_axi_o_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWVALID" *)
input wire s_axi_o_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o AWREADY" *)
output wire s_axi_o_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o WDATA" *)
input wire [31 : 0] s_axi_o_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o WSTRB" *)
input wire [3 : 0] s_axi_o_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o WLAST" *)
input wire s_axi_o_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o WVALID" *)
input wire s_axi_o_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o WREADY" *)
output wire s_axi_o_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o BRESP" *)
output wire [1 : 0] s_axi_o_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o BVALID" *)
output wire s_axi_o_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o BREADY" *)
input wire s_axi_o_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARADDR" *)
input wire [17 : 0] s_axi_o_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARLEN" *)
input wire [7 : 0] s_axi_o_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARSIZE" *)
input wire [2 : 0] s_axi_o_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARBURST" *)
input wire [1 : 0] s_axi_o_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARLOCK" *)
input wire s_axi_o_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARCACHE" *)
input wire [3 : 0] s_axi_o_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARPROT" *)
input wire [2 : 0] s_axi_o_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARVALID" *)
input wire s_axi_o_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o ARREADY" *)
output wire s_axi_o_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o RDATA" *)
output wire [31 : 0] s_axi_o_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o RRESP" *)
output wire [1 : 0] s_axi_o_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o RLAST" *)
output wire s_axi_o_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o RVALID" *)
output wire s_axi_o_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_o, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 149985016, ID_WIDTH 0, ADDR_WIDTH 18, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NU\
M_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_o RREADY" *)
input wire s_axi_o_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_ctrl_aclk, ASSOCIATED_RESET s_axi_ctrl_aresetn, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_ctrl_aclk CLK" *)
input wire s_axi_ctrl_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_ctrl_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_ctrl_aresetn RST" *)
input wire s_axi_ctrl_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl AWADDR" *)
input wire [3 : 0] s_axi_ctrl_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl AWPROT" *)
input wire [2 : 0] s_axi_ctrl_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl AWVALID" *)
input wire s_axi_ctrl_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl AWREADY" *)
output wire s_axi_ctrl_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl WDATA" *)
input wire [31 : 0] s_axi_ctrl_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl WSTRB" *)
input wire [3 : 0] s_axi_ctrl_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl WVALID" *)
input wire s_axi_ctrl_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl WREADY" *)
output wire s_axi_ctrl_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl BRESP" *)
output wire [1 : 0] s_axi_ctrl_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl BVALID" *)
output wire s_axi_ctrl_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl BREADY" *)
input wire s_axi_ctrl_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl ARADDR" *)
input wire [3 : 0] s_axi_ctrl_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl ARPROT" *)
input wire [2 : 0] s_axi_ctrl_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl ARVALID" *)
input wire s_axi_ctrl_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl ARREADY" *)
output wire s_axi_ctrl_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl RDATA" *)
output wire [31 : 0] s_axi_ctrl_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl RRESP" *)
output wire [1 : 0] s_axi_ctrl_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl RVALID" *)
output wire s_axi_ctrl_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_ctrl, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 149985016, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1\
, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl RREADY" *)
input wire s_axi_ctrl_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_intc_aclk, ASSOCIATED_RESET s_axi_intc_aresetn, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_intc_aclk CLK" *)
input wire s_axi_intc_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_intc_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_intc_aresetn RST" *)
input wire s_axi_intc_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc AWADDR" *)
input wire [8 : 0] s_axi_intc_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc AWVALID" *)
input wire s_axi_intc_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc AWREADY" *)
output wire s_axi_intc_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc WDATA" *)
input wire [31 : 0] s_axi_intc_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc WSTRB" *)
input wire [3 : 0] s_axi_intc_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc WVALID" *)
input wire s_axi_intc_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc WREADY" *)
output wire s_axi_intc_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc BRESP" *)
output wire [1 : 0] s_axi_intc_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc BVALID" *)
output wire s_axi_intc_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc BREADY" *)
input wire s_axi_intc_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc ARADDR" *)
input wire [8 : 0] s_axi_intc_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc ARVALID" *)
input wire s_axi_intc_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc ARREADY" *)
output wire s_axi_intc_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc RDATA" *)
output wire [31 : 0] s_axi_intc_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc RRESP" *)
output wire [1 : 0] s_axi_intc_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc RVALID" *)
output wire s_axi_intc_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_intc, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 149985016, ID_WIDTH 0, ADDR_WIDTH 9, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1\
, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_intc RREADY" *)
input wire s_axi_intc_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME irq, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 irq INTERRUPT" *)
output wire irq;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF s_axi_ctrl:s_axi_intc:s_axi_o:s_axi_qkv, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
input wire cdma_interrupt_in;
output wire single_iter_done;
output wire all_iter_done;

  head_dim_4_top_module #(
    .TOKENS(1024)
  ) inst (
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
    .s_axi_qkv_araddr(s_axi_qkv_araddr),
    .s_axi_qkv_arlen(s_axi_qkv_arlen),
    .s_axi_qkv_arsize(s_axi_qkv_arsize),
    .s_axi_qkv_arburst(s_axi_qkv_arburst),
    .s_axi_qkv_arlock(s_axi_qkv_arlock),
    .s_axi_qkv_arcache(s_axi_qkv_arcache),
    .s_axi_qkv_arprot(s_axi_qkv_arprot),
    .s_axi_qkv_arvalid(s_axi_qkv_arvalid),
    .s_axi_qkv_arready(s_axi_qkv_arready),
    .s_axi_qkv_rdata(s_axi_qkv_rdata),
    .s_axi_qkv_rresp(s_axi_qkv_rresp),
    .s_axi_qkv_rlast(s_axi_qkv_rlast),
    .s_axi_qkv_rvalid(s_axi_qkv_rvalid),
    .s_axi_qkv_rready(s_axi_qkv_rready),
    .s_axi_o_aclk(s_axi_o_aclk),
    .s_axi_o_aresetn(s_axi_o_aresetn),
    .s_axi_o_awaddr(s_axi_o_awaddr),
    .s_axi_o_awlen(s_axi_o_awlen),
    .s_axi_o_awsize(s_axi_o_awsize),
    .s_axi_o_awburst(s_axi_o_awburst),
    .s_axi_o_awlock(s_axi_o_awlock),
    .s_axi_o_awcache(s_axi_o_awcache),
    .s_axi_o_awprot(s_axi_o_awprot),
    .s_axi_o_awvalid(s_axi_o_awvalid),
    .s_axi_o_awready(s_axi_o_awready),
    .s_axi_o_wdata(s_axi_o_wdata),
    .s_axi_o_wstrb(s_axi_o_wstrb),
    .s_axi_o_wlast(s_axi_o_wlast),
    .s_axi_o_wvalid(s_axi_o_wvalid),
    .s_axi_o_wready(s_axi_o_wready),
    .s_axi_o_bresp(s_axi_o_bresp),
    .s_axi_o_bvalid(s_axi_o_bvalid),
    .s_axi_o_bready(s_axi_o_bready),
    .s_axi_o_araddr(s_axi_o_araddr),
    .s_axi_o_arlen(s_axi_o_arlen),
    .s_axi_o_arsize(s_axi_o_arsize),
    .s_axi_o_arburst(s_axi_o_arburst),
    .s_axi_o_arlock(s_axi_o_arlock),
    .s_axi_o_arcache(s_axi_o_arcache),
    .s_axi_o_arprot(s_axi_o_arprot),
    .s_axi_o_arvalid(s_axi_o_arvalid),
    .s_axi_o_arready(s_axi_o_arready),
    .s_axi_o_rdata(s_axi_o_rdata),
    .s_axi_o_rresp(s_axi_o_rresp),
    .s_axi_o_rlast(s_axi_o_rlast),
    .s_axi_o_rvalid(s_axi_o_rvalid),
    .s_axi_o_rready(s_axi_o_rready),
    .s_axi_ctrl_aclk(s_axi_ctrl_aclk),
    .s_axi_ctrl_aresetn(s_axi_ctrl_aresetn),
    .s_axi_ctrl_awaddr(s_axi_ctrl_awaddr),
    .s_axi_ctrl_awprot(s_axi_ctrl_awprot),
    .s_axi_ctrl_awvalid(s_axi_ctrl_awvalid),
    .s_axi_ctrl_awready(s_axi_ctrl_awready),
    .s_axi_ctrl_wdata(s_axi_ctrl_wdata),
    .s_axi_ctrl_wstrb(s_axi_ctrl_wstrb),
    .s_axi_ctrl_wvalid(s_axi_ctrl_wvalid),
    .s_axi_ctrl_wready(s_axi_ctrl_wready),
    .s_axi_ctrl_bresp(s_axi_ctrl_bresp),
    .s_axi_ctrl_bvalid(s_axi_ctrl_bvalid),
    .s_axi_ctrl_bready(s_axi_ctrl_bready),
    .s_axi_ctrl_araddr(s_axi_ctrl_araddr),
    .s_axi_ctrl_arprot(s_axi_ctrl_arprot),
    .s_axi_ctrl_arvalid(s_axi_ctrl_arvalid),
    .s_axi_ctrl_arready(s_axi_ctrl_arready),
    .s_axi_ctrl_rdata(s_axi_ctrl_rdata),
    .s_axi_ctrl_rresp(s_axi_ctrl_rresp),
    .s_axi_ctrl_rvalid(s_axi_ctrl_rvalid),
    .s_axi_ctrl_rready(s_axi_ctrl_rready),
    .s_axi_intc_aclk(s_axi_intc_aclk),
    .s_axi_intc_aresetn(s_axi_intc_aresetn),
    .s_axi_intc_awaddr(s_axi_intc_awaddr),
    .s_axi_intc_awvalid(s_axi_intc_awvalid),
    .s_axi_intc_awready(s_axi_intc_awready),
    .s_axi_intc_wdata(s_axi_intc_wdata),
    .s_axi_intc_wstrb(s_axi_intc_wstrb),
    .s_axi_intc_wvalid(s_axi_intc_wvalid),
    .s_axi_intc_wready(s_axi_intc_wready),
    .s_axi_intc_bresp(s_axi_intc_bresp),
    .s_axi_intc_bvalid(s_axi_intc_bvalid),
    .s_axi_intc_bready(s_axi_intc_bready),
    .s_axi_intc_araddr(s_axi_intc_araddr),
    .s_axi_intc_arvalid(s_axi_intc_arvalid),
    .s_axi_intc_arready(s_axi_intc_arready),
    .s_axi_intc_rdata(s_axi_intc_rdata),
    .s_axi_intc_rresp(s_axi_intc_rresp),
    .s_axi_intc_rvalid(s_axi_intc_rvalid),
    .s_axi_intc_rready(s_axi_intc_rready),
    .irq(irq),
    .clk(clk),
    .cdma_interrupt_in(cdma_interrupt_in),
    .single_iter_done(single_iter_done),
    .all_iter_done(all_iter_done)
  );
endmodule
