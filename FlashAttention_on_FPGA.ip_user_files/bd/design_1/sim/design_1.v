//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
//Date        : Mon May 11 01:06:57 2026
//Host        : DESKTOP-DDDGL8L running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=51,da_board_cnt=1,da_clkrst_cnt=51,da_zynq_ultra_ps_e_cnt=1,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   ();

  wire [31:0]axi_cdma_0_M_AXI_ARADDR;
  wire [1:0]axi_cdma_0_M_AXI_ARBURST;
  wire [3:0]axi_cdma_0_M_AXI_ARCACHE;
  wire [7:0]axi_cdma_0_M_AXI_ARLEN;
  wire [2:0]axi_cdma_0_M_AXI_ARPROT;
  wire axi_cdma_0_M_AXI_ARREADY;
  wire [2:0]axi_cdma_0_M_AXI_ARSIZE;
  wire axi_cdma_0_M_AXI_ARVALID;
  wire [31:0]axi_cdma_0_M_AXI_AWADDR;
  wire [1:0]axi_cdma_0_M_AXI_AWBURST;
  wire [3:0]axi_cdma_0_M_AXI_AWCACHE;
  wire [7:0]axi_cdma_0_M_AXI_AWLEN;
  wire [2:0]axi_cdma_0_M_AXI_AWPROT;
  wire axi_cdma_0_M_AXI_AWREADY;
  wire [2:0]axi_cdma_0_M_AXI_AWSIZE;
  wire axi_cdma_0_M_AXI_AWVALID;
  wire axi_cdma_0_M_AXI_BREADY;
  wire [1:0]axi_cdma_0_M_AXI_BRESP;
  wire axi_cdma_0_M_AXI_BVALID;
  wire [31:0]axi_cdma_0_M_AXI_RDATA;
  wire axi_cdma_0_M_AXI_RLAST;
  wire axi_cdma_0_M_AXI_RREADY;
  wire [1:0]axi_cdma_0_M_AXI_RRESP;
  wire axi_cdma_0_M_AXI_RVALID;
  wire [31:0]axi_cdma_0_M_AXI_WDATA;
  wire axi_cdma_0_M_AXI_WLAST;
  wire axi_cdma_0_M_AXI_WREADY;
  wire [3:0]axi_cdma_0_M_AXI_WSTRB;
  wire axi_cdma_0_M_AXI_WVALID;
  wire axi_cdma_0_cdma_introut;
  wire head_dim_4_top_module_0_irq;
  wire [48:0]ps8_0_axi_periph_M05_AXI_ARADDR;
  wire [1:0]ps8_0_axi_periph_M05_AXI_ARBURST;
  wire [3:0]ps8_0_axi_periph_M05_AXI_ARCACHE;
  wire [7:0]ps8_0_axi_periph_M05_AXI_ARLEN;
  wire [0:0]ps8_0_axi_periph_M05_AXI_ARLOCK;
  wire [2:0]ps8_0_axi_periph_M05_AXI_ARPROT;
  wire [3:0]ps8_0_axi_periph_M05_AXI_ARQOS;
  wire ps8_0_axi_periph_M05_AXI_ARREADY;
  wire [2:0]ps8_0_axi_periph_M05_AXI_ARSIZE;
  wire ps8_0_axi_periph_M05_AXI_ARVALID;
  wire [48:0]ps8_0_axi_periph_M05_AXI_AWADDR;
  wire [1:0]ps8_0_axi_periph_M05_AXI_AWBURST;
  wire [3:0]ps8_0_axi_periph_M05_AXI_AWCACHE;
  wire [7:0]ps8_0_axi_periph_M05_AXI_AWLEN;
  wire [0:0]ps8_0_axi_periph_M05_AXI_AWLOCK;
  wire [2:0]ps8_0_axi_periph_M05_AXI_AWPROT;
  wire [3:0]ps8_0_axi_periph_M05_AXI_AWQOS;
  wire ps8_0_axi_periph_M05_AXI_AWREADY;
  wire [2:0]ps8_0_axi_periph_M05_AXI_AWSIZE;
  wire ps8_0_axi_periph_M05_AXI_AWVALID;
  wire ps8_0_axi_periph_M05_AXI_BREADY;
  wire [1:0]ps8_0_axi_periph_M05_AXI_BRESP;
  wire ps8_0_axi_periph_M05_AXI_BVALID;
  wire [127:0]ps8_0_axi_periph_M05_AXI_RDATA;
  wire ps8_0_axi_periph_M05_AXI_RLAST;
  wire ps8_0_axi_periph_M05_AXI_RREADY;
  wire [1:0]ps8_0_axi_periph_M05_AXI_RRESP;
  wire ps8_0_axi_periph_M05_AXI_RVALID;
  wire [127:0]ps8_0_axi_periph_M05_AXI_WDATA;
  wire ps8_0_axi_periph_M05_AXI_WLAST;
  wire ps8_0_axi_periph_M05_AXI_WREADY;
  wire [15:0]ps8_0_axi_periph_M05_AXI_WSTRB;
  wire ps8_0_axi_periph_M05_AXI_WVALID;
  wire [0:0]rst_ps8_0_149M_peripheral_aresetn;
  wire [17:0]smartconnect_0_M00_AXI_ARADDR;
  wire [1:0]smartconnect_0_M00_AXI_ARBURST;
  wire [3:0]smartconnect_0_M00_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M00_AXI_ARLEN;
  wire [0:0]smartconnect_0_M00_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M00_AXI_ARPROT;
  wire smartconnect_0_M00_AXI_ARREADY;
  wire [2:0]smartconnect_0_M00_AXI_ARSIZE;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [17:0]smartconnect_0_M00_AXI_AWADDR;
  wire [1:0]smartconnect_0_M00_AXI_AWBURST;
  wire [3:0]smartconnect_0_M00_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M00_AXI_AWLEN;
  wire [0:0]smartconnect_0_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire [2:0]smartconnect_0_M00_AXI_AWSIZE;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [31:0]smartconnect_0_M00_AXI_RDATA;
  wire smartconnect_0_M00_AXI_RLAST;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire smartconnect_0_M00_AXI_RVALID;
  wire [31:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WLAST;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [3:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [15:0]smartconnect_0_M01_AXI_ARADDR;
  wire [1:0]smartconnect_0_M01_AXI_ARBURST;
  wire [3:0]smartconnect_0_M01_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M01_AXI_ARLEN;
  wire [0:0]smartconnect_0_M01_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M01_AXI_ARPROT;
  wire smartconnect_0_M01_AXI_ARREADY;
  wire [2:0]smartconnect_0_M01_AXI_ARSIZE;
  wire smartconnect_0_M01_AXI_ARVALID;
  wire [15:0]smartconnect_0_M01_AXI_AWADDR;
  wire [1:0]smartconnect_0_M01_AXI_AWBURST;
  wire [3:0]smartconnect_0_M01_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M01_AXI_AWLEN;
  wire [0:0]smartconnect_0_M01_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M01_AXI_AWPROT;
  wire smartconnect_0_M01_AXI_AWREADY;
  wire [2:0]smartconnect_0_M01_AXI_AWSIZE;
  wire smartconnect_0_M01_AXI_AWVALID;
  wire smartconnect_0_M01_AXI_BREADY;
  wire [1:0]smartconnect_0_M01_AXI_BRESP;
  wire smartconnect_0_M01_AXI_BVALID;
  wire [31:0]smartconnect_0_M01_AXI_RDATA;
  wire smartconnect_0_M01_AXI_RLAST;
  wire smartconnect_0_M01_AXI_RREADY;
  wire [1:0]smartconnect_0_M01_AXI_RRESP;
  wire smartconnect_0_M01_AXI_RVALID;
  wire [31:0]smartconnect_0_M01_AXI_WDATA;
  wire smartconnect_0_M01_AXI_WLAST;
  wire smartconnect_0_M01_AXI_WREADY;
  wire [3:0]smartconnect_0_M01_AXI_WSTRB;
  wire smartconnect_0_M01_AXI_WVALID;
  wire [3:0]smartconnect_1_M00_AXI_ARADDR;
  wire [2:0]smartconnect_1_M00_AXI_ARPROT;
  wire smartconnect_1_M00_AXI_ARREADY;
  wire smartconnect_1_M00_AXI_ARVALID;
  wire [3:0]smartconnect_1_M00_AXI_AWADDR;
  wire [2:0]smartconnect_1_M00_AXI_AWPROT;
  wire smartconnect_1_M00_AXI_AWREADY;
  wire smartconnect_1_M00_AXI_AWVALID;
  wire smartconnect_1_M00_AXI_BREADY;
  wire [1:0]smartconnect_1_M00_AXI_BRESP;
  wire smartconnect_1_M00_AXI_BVALID;
  wire [31:0]smartconnect_1_M00_AXI_RDATA;
  wire smartconnect_1_M00_AXI_RREADY;
  wire [1:0]smartconnect_1_M00_AXI_RRESP;
  wire smartconnect_1_M00_AXI_RVALID;
  wire [31:0]smartconnect_1_M00_AXI_WDATA;
  wire smartconnect_1_M00_AXI_WREADY;
  wire [3:0]smartconnect_1_M00_AXI_WSTRB;
  wire smartconnect_1_M00_AXI_WVALID;
  wire [8:0]smartconnect_1_M01_AXI_ARADDR;
  wire smartconnect_1_M01_AXI_ARREADY;
  wire smartconnect_1_M01_AXI_ARVALID;
  wire [8:0]smartconnect_1_M01_AXI_AWADDR;
  wire smartconnect_1_M01_AXI_AWREADY;
  wire smartconnect_1_M01_AXI_AWVALID;
  wire smartconnect_1_M01_AXI_BREADY;
  wire [1:0]smartconnect_1_M01_AXI_BRESP;
  wire smartconnect_1_M01_AXI_BVALID;
  wire [31:0]smartconnect_1_M01_AXI_RDATA;
  wire smartconnect_1_M01_AXI_RREADY;
  wire [1:0]smartconnect_1_M01_AXI_RRESP;
  wire smartconnect_1_M01_AXI_RVALID;
  wire [31:0]smartconnect_1_M01_AXI_WDATA;
  wire smartconnect_1_M01_AXI_WREADY;
  wire [3:0]smartconnect_1_M01_AXI_WSTRB;
  wire smartconnect_1_M01_AXI_WVALID;
  wire [5:0]smartconnect_1_M02_AXI_ARADDR;
  wire smartconnect_1_M02_AXI_ARREADY;
  wire smartconnect_1_M02_AXI_ARVALID;
  wire [5:0]smartconnect_1_M02_AXI_AWADDR;
  wire smartconnect_1_M02_AXI_AWREADY;
  wire smartconnect_1_M02_AXI_AWVALID;
  wire smartconnect_1_M02_AXI_BREADY;
  wire [1:0]smartconnect_1_M02_AXI_BRESP;
  wire smartconnect_1_M02_AXI_BVALID;
  wire [31:0]smartconnect_1_M02_AXI_RDATA;
  wire smartconnect_1_M02_AXI_RREADY;
  wire [1:0]smartconnect_1_M02_AXI_RRESP;
  wire smartconnect_1_M02_AXI_RVALID;
  wire [31:0]smartconnect_1_M02_AXI_WDATA;
  wire smartconnect_1_M02_AXI_WREADY;
  wire smartconnect_1_M02_AXI_WVALID;
  wire [8:0]smartconnect_1_M03_AXI_ARADDR;
  wire smartconnect_1_M03_AXI_ARREADY;
  wire smartconnect_1_M03_AXI_ARVALID;
  wire [8:0]smartconnect_1_M03_AXI_AWADDR;
  wire smartconnect_1_M03_AXI_AWREADY;
  wire smartconnect_1_M03_AXI_AWVALID;
  wire smartconnect_1_M03_AXI_BREADY;
  wire [1:0]smartconnect_1_M03_AXI_BRESP;
  wire smartconnect_1_M03_AXI_BVALID;
  wire [31:0]smartconnect_1_M03_AXI_RDATA;
  wire smartconnect_1_M03_AXI_RREADY;
  wire [1:0]smartconnect_1_M03_AXI_RRESP;
  wire smartconnect_1_M03_AXI_RVALID;
  wire [31:0]smartconnect_1_M03_AXI_WDATA;
  wire smartconnect_1_M03_AXI_WREADY;
  wire [3:0]smartconnect_1_M03_AXI_WSTRB;
  wire smartconnect_1_M03_AXI_WVALID;
  wire [39:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARUSER;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID;
  wire [39:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWUSER;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID;
  wire [31:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID;
  wire [31:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID;
  wire zynq_ultra_ps_e_0_pl_clk0;
  wire zynq_ultra_ps_e_0_pl_resetn0;

  design_1_axi_cdma_0_0 axi_cdma_0
       (.cdma_introut(axi_cdma_0_cdma_introut),
        .m_axi_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .m_axi_araddr(axi_cdma_0_M_AXI_ARADDR),
        .m_axi_arburst(axi_cdma_0_M_AXI_ARBURST),
        .m_axi_arcache(axi_cdma_0_M_AXI_ARCACHE),
        .m_axi_arlen(axi_cdma_0_M_AXI_ARLEN),
        .m_axi_arprot(axi_cdma_0_M_AXI_ARPROT),
        .m_axi_arready(axi_cdma_0_M_AXI_ARREADY),
        .m_axi_arsize(axi_cdma_0_M_AXI_ARSIZE),
        .m_axi_arvalid(axi_cdma_0_M_AXI_ARVALID),
        .m_axi_awaddr(axi_cdma_0_M_AXI_AWADDR),
        .m_axi_awburst(axi_cdma_0_M_AXI_AWBURST),
        .m_axi_awcache(axi_cdma_0_M_AXI_AWCACHE),
        .m_axi_awlen(axi_cdma_0_M_AXI_AWLEN),
        .m_axi_awprot(axi_cdma_0_M_AXI_AWPROT),
        .m_axi_awready(axi_cdma_0_M_AXI_AWREADY),
        .m_axi_awsize(axi_cdma_0_M_AXI_AWSIZE),
        .m_axi_awvalid(axi_cdma_0_M_AXI_AWVALID),
        .m_axi_bready(axi_cdma_0_M_AXI_BREADY),
        .m_axi_bresp(axi_cdma_0_M_AXI_BRESP),
        .m_axi_bvalid(axi_cdma_0_M_AXI_BVALID),
        .m_axi_rdata(axi_cdma_0_M_AXI_RDATA),
        .m_axi_rlast(axi_cdma_0_M_AXI_RLAST),
        .m_axi_rready(axi_cdma_0_M_AXI_RREADY),
        .m_axi_rresp(axi_cdma_0_M_AXI_RRESP),
        .m_axi_rvalid(axi_cdma_0_M_AXI_RVALID),
        .m_axi_wdata(axi_cdma_0_M_AXI_WDATA),
        .m_axi_wlast(axi_cdma_0_M_AXI_WLAST),
        .m_axi_wready(axi_cdma_0_M_AXI_WREADY),
        .m_axi_wstrb(axi_cdma_0_M_AXI_WSTRB),
        .m_axi_wvalid(axi_cdma_0_M_AXI_WVALID),
        .s_axi_lite_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_lite_araddr(smartconnect_1_M02_AXI_ARADDR),
        .s_axi_lite_aresetn(rst_ps8_0_149M_peripheral_aresetn),
        .s_axi_lite_arready(smartconnect_1_M02_AXI_ARREADY),
        .s_axi_lite_arvalid(smartconnect_1_M02_AXI_ARVALID),
        .s_axi_lite_awaddr(smartconnect_1_M02_AXI_AWADDR),
        .s_axi_lite_awready(smartconnect_1_M02_AXI_AWREADY),
        .s_axi_lite_awvalid(smartconnect_1_M02_AXI_AWVALID),
        .s_axi_lite_bready(smartconnect_1_M02_AXI_BREADY),
        .s_axi_lite_bresp(smartconnect_1_M02_AXI_BRESP),
        .s_axi_lite_bvalid(smartconnect_1_M02_AXI_BVALID),
        .s_axi_lite_rdata(smartconnect_1_M02_AXI_RDATA),
        .s_axi_lite_rready(smartconnect_1_M02_AXI_RREADY),
        .s_axi_lite_rresp(smartconnect_1_M02_AXI_RRESP),
        .s_axi_lite_rvalid(smartconnect_1_M02_AXI_RVALID),
        .s_axi_lite_wdata(smartconnect_1_M02_AXI_WDATA),
        .s_axi_lite_wready(smartconnect_1_M02_AXI_WREADY),
        .s_axi_lite_wvalid(smartconnect_1_M02_AXI_WVALID));
  design_1_axi_gpio_0_0 axi_gpio_0
       (.gpio_io_i(head_dim_4_top_module_0_irq),
        .s_axi_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_araddr(smartconnect_1_M03_AXI_ARADDR),
        .s_axi_aresetn(rst_ps8_0_149M_peripheral_aresetn),
        .s_axi_arready(smartconnect_1_M03_AXI_ARREADY),
        .s_axi_arvalid(smartconnect_1_M03_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_1_M03_AXI_AWADDR),
        .s_axi_awready(smartconnect_1_M03_AXI_AWREADY),
        .s_axi_awvalid(smartconnect_1_M03_AXI_AWVALID),
        .s_axi_bready(smartconnect_1_M03_AXI_BREADY),
        .s_axi_bresp(smartconnect_1_M03_AXI_BRESP),
        .s_axi_bvalid(smartconnect_1_M03_AXI_BVALID),
        .s_axi_rdata(smartconnect_1_M03_AXI_RDATA),
        .s_axi_rready(smartconnect_1_M03_AXI_RREADY),
        .s_axi_rresp(smartconnect_1_M03_AXI_RRESP),
        .s_axi_rvalid(smartconnect_1_M03_AXI_RVALID),
        .s_axi_wdata(smartconnect_1_M03_AXI_WDATA),
        .s_axi_wready(smartconnect_1_M03_AXI_WREADY),
        .s_axi_wstrb(smartconnect_1_M03_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_1_M03_AXI_WVALID));
  design_1_head_dim_4_top_module_0_2 head_dim_4_top_module_0
       (.cdma_interrupt_in(axi_cdma_0_cdma_introut),
        .clk(zynq_ultra_ps_e_0_pl_clk0),
        .irq(head_dim_4_top_module_0_irq),
        .s_axi_ctrl_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_ctrl_araddr(smartconnect_1_M00_AXI_ARADDR),
        .s_axi_ctrl_aresetn(rst_ps8_0_149M_peripheral_aresetn),
        .s_axi_ctrl_arprot(smartconnect_1_M00_AXI_ARPROT),
        .s_axi_ctrl_arready(smartconnect_1_M00_AXI_ARREADY),
        .s_axi_ctrl_arvalid(smartconnect_1_M00_AXI_ARVALID),
        .s_axi_ctrl_awaddr(smartconnect_1_M00_AXI_AWADDR),
        .s_axi_ctrl_awprot(smartconnect_1_M00_AXI_AWPROT),
        .s_axi_ctrl_awready(smartconnect_1_M00_AXI_AWREADY),
        .s_axi_ctrl_awvalid(smartconnect_1_M00_AXI_AWVALID),
        .s_axi_ctrl_bready(smartconnect_1_M00_AXI_BREADY),
        .s_axi_ctrl_bresp(smartconnect_1_M00_AXI_BRESP),
        .s_axi_ctrl_bvalid(smartconnect_1_M00_AXI_BVALID),
        .s_axi_ctrl_rdata(smartconnect_1_M00_AXI_RDATA),
        .s_axi_ctrl_rready(smartconnect_1_M00_AXI_RREADY),
        .s_axi_ctrl_rresp(smartconnect_1_M00_AXI_RRESP),
        .s_axi_ctrl_rvalid(smartconnect_1_M00_AXI_RVALID),
        .s_axi_ctrl_wdata(smartconnect_1_M00_AXI_WDATA),
        .s_axi_ctrl_wready(smartconnect_1_M00_AXI_WREADY),
        .s_axi_ctrl_wstrb(smartconnect_1_M00_AXI_WSTRB),
        .s_axi_ctrl_wvalid(smartconnect_1_M00_AXI_WVALID),
        .s_axi_intc_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_intc_araddr(smartconnect_1_M01_AXI_ARADDR),
        .s_axi_intc_aresetn(rst_ps8_0_149M_peripheral_aresetn),
        .s_axi_intc_arready(smartconnect_1_M01_AXI_ARREADY),
        .s_axi_intc_arvalid(smartconnect_1_M01_AXI_ARVALID),
        .s_axi_intc_awaddr(smartconnect_1_M01_AXI_AWADDR),
        .s_axi_intc_awready(smartconnect_1_M01_AXI_AWREADY),
        .s_axi_intc_awvalid(smartconnect_1_M01_AXI_AWVALID),
        .s_axi_intc_bready(smartconnect_1_M01_AXI_BREADY),
        .s_axi_intc_bresp(smartconnect_1_M01_AXI_BRESP),
        .s_axi_intc_bvalid(smartconnect_1_M01_AXI_BVALID),
        .s_axi_intc_rdata(smartconnect_1_M01_AXI_RDATA),
        .s_axi_intc_rready(smartconnect_1_M01_AXI_RREADY),
        .s_axi_intc_rresp(smartconnect_1_M01_AXI_RRESP),
        .s_axi_intc_rvalid(smartconnect_1_M01_AXI_RVALID),
        .s_axi_intc_wdata(smartconnect_1_M01_AXI_WDATA),
        .s_axi_intc_wready(smartconnect_1_M01_AXI_WREADY),
        .s_axi_intc_wstrb(smartconnect_1_M01_AXI_WSTRB),
        .s_axi_intc_wvalid(smartconnect_1_M01_AXI_WVALID),
        .s_axi_o_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_o_araddr(smartconnect_0_M00_AXI_ARADDR),
        .s_axi_o_arburst(smartconnect_0_M00_AXI_ARBURST),
        .s_axi_o_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .s_axi_o_aresetn(rst_ps8_0_149M_peripheral_aresetn),
        .s_axi_o_arlen(smartconnect_0_M00_AXI_ARLEN),
        .s_axi_o_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .s_axi_o_arprot(smartconnect_0_M00_AXI_ARPROT),
        .s_axi_o_arready(smartconnect_0_M00_AXI_ARREADY),
        .s_axi_o_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .s_axi_o_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .s_axi_o_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .s_axi_o_awburst(smartconnect_0_M00_AXI_AWBURST),
        .s_axi_o_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .s_axi_o_awlen(smartconnect_0_M00_AXI_AWLEN),
        .s_axi_o_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .s_axi_o_awprot(smartconnect_0_M00_AXI_AWPROT),
        .s_axi_o_awready(smartconnect_0_M00_AXI_AWREADY),
        .s_axi_o_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .s_axi_o_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .s_axi_o_bready(smartconnect_0_M00_AXI_BREADY),
        .s_axi_o_bresp(smartconnect_0_M00_AXI_BRESP),
        .s_axi_o_bvalid(smartconnect_0_M00_AXI_BVALID),
        .s_axi_o_rdata(smartconnect_0_M00_AXI_RDATA),
        .s_axi_o_rlast(smartconnect_0_M00_AXI_RLAST),
        .s_axi_o_rready(smartconnect_0_M00_AXI_RREADY),
        .s_axi_o_rresp(smartconnect_0_M00_AXI_RRESP),
        .s_axi_o_rvalid(smartconnect_0_M00_AXI_RVALID),
        .s_axi_o_wdata(smartconnect_0_M00_AXI_WDATA),
        .s_axi_o_wlast(smartconnect_0_M00_AXI_WLAST),
        .s_axi_o_wready(smartconnect_0_M00_AXI_WREADY),
        .s_axi_o_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .s_axi_o_wvalid(smartconnect_0_M00_AXI_WVALID),
        .s_axi_qkv_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_qkv_araddr(smartconnect_0_M01_AXI_ARADDR),
        .s_axi_qkv_arburst(smartconnect_0_M01_AXI_ARBURST),
        .s_axi_qkv_arcache(smartconnect_0_M01_AXI_ARCACHE),
        .s_axi_qkv_aresetn(rst_ps8_0_149M_peripheral_aresetn),
        .s_axi_qkv_arlen(smartconnect_0_M01_AXI_ARLEN),
        .s_axi_qkv_arlock(smartconnect_0_M01_AXI_ARLOCK),
        .s_axi_qkv_arprot(smartconnect_0_M01_AXI_ARPROT),
        .s_axi_qkv_arready(smartconnect_0_M01_AXI_ARREADY),
        .s_axi_qkv_arsize(smartconnect_0_M01_AXI_ARSIZE),
        .s_axi_qkv_arvalid(smartconnect_0_M01_AXI_ARVALID),
        .s_axi_qkv_awaddr(smartconnect_0_M01_AXI_AWADDR),
        .s_axi_qkv_awburst(smartconnect_0_M01_AXI_AWBURST),
        .s_axi_qkv_awcache(smartconnect_0_M01_AXI_AWCACHE),
        .s_axi_qkv_awlen(smartconnect_0_M01_AXI_AWLEN),
        .s_axi_qkv_awlock(smartconnect_0_M01_AXI_AWLOCK),
        .s_axi_qkv_awprot(smartconnect_0_M01_AXI_AWPROT),
        .s_axi_qkv_awready(smartconnect_0_M01_AXI_AWREADY),
        .s_axi_qkv_awsize(smartconnect_0_M01_AXI_AWSIZE),
        .s_axi_qkv_awvalid(smartconnect_0_M01_AXI_AWVALID),
        .s_axi_qkv_bready(smartconnect_0_M01_AXI_BREADY),
        .s_axi_qkv_bresp(smartconnect_0_M01_AXI_BRESP),
        .s_axi_qkv_bvalid(smartconnect_0_M01_AXI_BVALID),
        .s_axi_qkv_rdata(smartconnect_0_M01_AXI_RDATA),
        .s_axi_qkv_rlast(smartconnect_0_M01_AXI_RLAST),
        .s_axi_qkv_rready(smartconnect_0_M01_AXI_RREADY),
        .s_axi_qkv_rresp(smartconnect_0_M01_AXI_RRESP),
        .s_axi_qkv_rvalid(smartconnect_0_M01_AXI_RVALID),
        .s_axi_qkv_wdata(smartconnect_0_M01_AXI_WDATA),
        .s_axi_qkv_wlast(smartconnect_0_M01_AXI_WLAST),
        .s_axi_qkv_wready(smartconnect_0_M01_AXI_WREADY),
        .s_axi_qkv_wstrb(smartconnect_0_M01_AXI_WSTRB),
        .s_axi_qkv_wvalid(smartconnect_0_M01_AXI_WVALID));
  design_1_rst_ps8_0_149M_0 rst_ps8_0_149M
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(zynq_ultra_ps_e_0_pl_resetn0),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_ps8_0_149M_peripheral_aresetn),
        .slowest_sync_clk(zynq_ultra_ps_e_0_pl_clk0));
  design_1_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arburst(smartconnect_0_M00_AXI_ARBURST),
        .M00_AXI_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .M00_AXI_arlen(smartconnect_0_M00_AXI_ARLEN),
        .M00_AXI_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .M00_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .M00_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .M00_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awburst(smartconnect_0_M00_AXI_AWBURST),
        .M00_AXI_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .M00_AXI_awlen(smartconnect_0_M00_AXI_AWLEN),
        .M00_AXI_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .M00_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .M00_AXI_rlast(smartconnect_0_M00_AXI_RLAST),
        .M00_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wlast(smartconnect_0_M00_AXI_WLAST),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .M01_AXI_araddr(smartconnect_0_M01_AXI_ARADDR),
        .M01_AXI_arburst(smartconnect_0_M01_AXI_ARBURST),
        .M01_AXI_arcache(smartconnect_0_M01_AXI_ARCACHE),
        .M01_AXI_arlen(smartconnect_0_M01_AXI_ARLEN),
        .M01_AXI_arlock(smartconnect_0_M01_AXI_ARLOCK),
        .M01_AXI_arprot(smartconnect_0_M01_AXI_ARPROT),
        .M01_AXI_arready(smartconnect_0_M01_AXI_ARREADY),
        .M01_AXI_arsize(smartconnect_0_M01_AXI_ARSIZE),
        .M01_AXI_arvalid(smartconnect_0_M01_AXI_ARVALID),
        .M01_AXI_awaddr(smartconnect_0_M01_AXI_AWADDR),
        .M01_AXI_awburst(smartconnect_0_M01_AXI_AWBURST),
        .M01_AXI_awcache(smartconnect_0_M01_AXI_AWCACHE),
        .M01_AXI_awlen(smartconnect_0_M01_AXI_AWLEN),
        .M01_AXI_awlock(smartconnect_0_M01_AXI_AWLOCK),
        .M01_AXI_awprot(smartconnect_0_M01_AXI_AWPROT),
        .M01_AXI_awready(smartconnect_0_M01_AXI_AWREADY),
        .M01_AXI_awsize(smartconnect_0_M01_AXI_AWSIZE),
        .M01_AXI_awvalid(smartconnect_0_M01_AXI_AWVALID),
        .M01_AXI_bready(smartconnect_0_M01_AXI_BREADY),
        .M01_AXI_bresp(smartconnect_0_M01_AXI_BRESP),
        .M01_AXI_bvalid(smartconnect_0_M01_AXI_BVALID),
        .M01_AXI_rdata(smartconnect_0_M01_AXI_RDATA),
        .M01_AXI_rlast(smartconnect_0_M01_AXI_RLAST),
        .M01_AXI_rready(smartconnect_0_M01_AXI_RREADY),
        .M01_AXI_rresp(smartconnect_0_M01_AXI_RRESP),
        .M01_AXI_rvalid(smartconnect_0_M01_AXI_RVALID),
        .M01_AXI_wdata(smartconnect_0_M01_AXI_WDATA),
        .M01_AXI_wlast(smartconnect_0_M01_AXI_WLAST),
        .M01_AXI_wready(smartconnect_0_M01_AXI_WREADY),
        .M01_AXI_wstrb(smartconnect_0_M01_AXI_WSTRB),
        .M01_AXI_wvalid(smartconnect_0_M01_AXI_WVALID),
        .M02_AXI_araddr(ps8_0_axi_periph_M05_AXI_ARADDR),
        .M02_AXI_arburst(ps8_0_axi_periph_M05_AXI_ARBURST),
        .M02_AXI_arcache(ps8_0_axi_periph_M05_AXI_ARCACHE),
        .M02_AXI_arlen(ps8_0_axi_periph_M05_AXI_ARLEN),
        .M02_AXI_arlock(ps8_0_axi_periph_M05_AXI_ARLOCK),
        .M02_AXI_arprot(ps8_0_axi_periph_M05_AXI_ARPROT),
        .M02_AXI_arqos(ps8_0_axi_periph_M05_AXI_ARQOS),
        .M02_AXI_arready(ps8_0_axi_periph_M05_AXI_ARREADY),
        .M02_AXI_arsize(ps8_0_axi_periph_M05_AXI_ARSIZE),
        .M02_AXI_arvalid(ps8_0_axi_periph_M05_AXI_ARVALID),
        .M02_AXI_awaddr(ps8_0_axi_periph_M05_AXI_AWADDR),
        .M02_AXI_awburst(ps8_0_axi_periph_M05_AXI_AWBURST),
        .M02_AXI_awcache(ps8_0_axi_periph_M05_AXI_AWCACHE),
        .M02_AXI_awlen(ps8_0_axi_periph_M05_AXI_AWLEN),
        .M02_AXI_awlock(ps8_0_axi_periph_M05_AXI_AWLOCK),
        .M02_AXI_awprot(ps8_0_axi_periph_M05_AXI_AWPROT),
        .M02_AXI_awqos(ps8_0_axi_periph_M05_AXI_AWQOS),
        .M02_AXI_awready(ps8_0_axi_periph_M05_AXI_AWREADY),
        .M02_AXI_awsize(ps8_0_axi_periph_M05_AXI_AWSIZE),
        .M02_AXI_awvalid(ps8_0_axi_periph_M05_AXI_AWVALID),
        .M02_AXI_bready(ps8_0_axi_periph_M05_AXI_BREADY),
        .M02_AXI_bresp(ps8_0_axi_periph_M05_AXI_BRESP),
        .M02_AXI_bvalid(ps8_0_axi_periph_M05_AXI_BVALID),
        .M02_AXI_rdata(ps8_0_axi_periph_M05_AXI_RDATA),
        .M02_AXI_rlast(ps8_0_axi_periph_M05_AXI_RLAST),
        .M02_AXI_rready(ps8_0_axi_periph_M05_AXI_RREADY),
        .M02_AXI_rresp(ps8_0_axi_periph_M05_AXI_RRESP),
        .M02_AXI_rvalid(ps8_0_axi_periph_M05_AXI_RVALID),
        .M02_AXI_wdata(ps8_0_axi_periph_M05_AXI_WDATA),
        .M02_AXI_wlast(ps8_0_axi_periph_M05_AXI_WLAST),
        .M02_AXI_wready(ps8_0_axi_periph_M05_AXI_WREADY),
        .M02_AXI_wstrb(ps8_0_axi_periph_M05_AXI_WSTRB),
        .M02_AXI_wvalid(ps8_0_axi_periph_M05_AXI_WVALID),
        .S00_AXI_araddr(axi_cdma_0_M_AXI_ARADDR),
        .S00_AXI_arburst(axi_cdma_0_M_AXI_ARBURST),
        .S00_AXI_arcache(axi_cdma_0_M_AXI_ARCACHE),
        .S00_AXI_arlen(axi_cdma_0_M_AXI_ARLEN),
        .S00_AXI_arlock(1'b0),
        .S00_AXI_arprot(axi_cdma_0_M_AXI_ARPROT),
        .S00_AXI_arqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_arready(axi_cdma_0_M_AXI_ARREADY),
        .S00_AXI_arsize(axi_cdma_0_M_AXI_ARSIZE),
        .S00_AXI_arvalid(axi_cdma_0_M_AXI_ARVALID),
        .S00_AXI_awaddr(axi_cdma_0_M_AXI_AWADDR),
        .S00_AXI_awburst(axi_cdma_0_M_AXI_AWBURST),
        .S00_AXI_awcache(axi_cdma_0_M_AXI_AWCACHE),
        .S00_AXI_awlen(axi_cdma_0_M_AXI_AWLEN),
        .S00_AXI_awlock(1'b0),
        .S00_AXI_awprot(axi_cdma_0_M_AXI_AWPROT),
        .S00_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_awready(axi_cdma_0_M_AXI_AWREADY),
        .S00_AXI_awsize(axi_cdma_0_M_AXI_AWSIZE),
        .S00_AXI_awvalid(axi_cdma_0_M_AXI_AWVALID),
        .S00_AXI_bready(axi_cdma_0_M_AXI_BREADY),
        .S00_AXI_bresp(axi_cdma_0_M_AXI_BRESP),
        .S00_AXI_bvalid(axi_cdma_0_M_AXI_BVALID),
        .S00_AXI_rdata(axi_cdma_0_M_AXI_RDATA),
        .S00_AXI_rlast(axi_cdma_0_M_AXI_RLAST),
        .S00_AXI_rready(axi_cdma_0_M_AXI_RREADY),
        .S00_AXI_rresp(axi_cdma_0_M_AXI_RRESP),
        .S00_AXI_rvalid(axi_cdma_0_M_AXI_RVALID),
        .S00_AXI_wdata(axi_cdma_0_M_AXI_WDATA),
        .S00_AXI_wlast(axi_cdma_0_M_AXI_WLAST),
        .S00_AXI_wready(axi_cdma_0_M_AXI_WREADY),
        .S00_AXI_wstrb(axi_cdma_0_M_AXI_WSTRB),
        .S00_AXI_wvalid(axi_cdma_0_M_AXI_WVALID),
        .aclk(zynq_ultra_ps_e_0_pl_clk0),
        .aresetn(rst_ps8_0_149M_peripheral_aresetn));
  design_1_smartconnect_1_0 smartconnect_1
       (.M00_AXI_araddr(smartconnect_1_M00_AXI_ARADDR),
        .M00_AXI_arprot(smartconnect_1_M00_AXI_ARPROT),
        .M00_AXI_arready(smartconnect_1_M00_AXI_ARREADY),
        .M00_AXI_arvalid(smartconnect_1_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_1_M00_AXI_AWADDR),
        .M00_AXI_awprot(smartconnect_1_M00_AXI_AWPROT),
        .M00_AXI_awready(smartconnect_1_M00_AXI_AWREADY),
        .M00_AXI_awvalid(smartconnect_1_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_1_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_1_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_1_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_1_M00_AXI_RDATA),
        .M00_AXI_rready(smartconnect_1_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_1_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_1_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_1_M00_AXI_WDATA),
        .M00_AXI_wready(smartconnect_1_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_1_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_1_M00_AXI_WVALID),
        .M01_AXI_araddr(smartconnect_1_M01_AXI_ARADDR),
        .M01_AXI_arready(smartconnect_1_M01_AXI_ARREADY),
        .M01_AXI_arvalid(smartconnect_1_M01_AXI_ARVALID),
        .M01_AXI_awaddr(smartconnect_1_M01_AXI_AWADDR),
        .M01_AXI_awready(smartconnect_1_M01_AXI_AWREADY),
        .M01_AXI_awvalid(smartconnect_1_M01_AXI_AWVALID),
        .M01_AXI_bready(smartconnect_1_M01_AXI_BREADY),
        .M01_AXI_bresp(smartconnect_1_M01_AXI_BRESP),
        .M01_AXI_bvalid(smartconnect_1_M01_AXI_BVALID),
        .M01_AXI_rdata(smartconnect_1_M01_AXI_RDATA),
        .M01_AXI_rready(smartconnect_1_M01_AXI_RREADY),
        .M01_AXI_rresp(smartconnect_1_M01_AXI_RRESP),
        .M01_AXI_rvalid(smartconnect_1_M01_AXI_RVALID),
        .M01_AXI_wdata(smartconnect_1_M01_AXI_WDATA),
        .M01_AXI_wready(smartconnect_1_M01_AXI_WREADY),
        .M01_AXI_wstrb(smartconnect_1_M01_AXI_WSTRB),
        .M01_AXI_wvalid(smartconnect_1_M01_AXI_WVALID),
        .M02_AXI_araddr(smartconnect_1_M02_AXI_ARADDR),
        .M02_AXI_arready(smartconnect_1_M02_AXI_ARREADY),
        .M02_AXI_arvalid(smartconnect_1_M02_AXI_ARVALID),
        .M02_AXI_awaddr(smartconnect_1_M02_AXI_AWADDR),
        .M02_AXI_awready(smartconnect_1_M02_AXI_AWREADY),
        .M02_AXI_awvalid(smartconnect_1_M02_AXI_AWVALID),
        .M02_AXI_bready(smartconnect_1_M02_AXI_BREADY),
        .M02_AXI_bresp(smartconnect_1_M02_AXI_BRESP),
        .M02_AXI_bvalid(smartconnect_1_M02_AXI_BVALID),
        .M02_AXI_rdata(smartconnect_1_M02_AXI_RDATA),
        .M02_AXI_rready(smartconnect_1_M02_AXI_RREADY),
        .M02_AXI_rresp(smartconnect_1_M02_AXI_RRESP),
        .M02_AXI_rvalid(smartconnect_1_M02_AXI_RVALID),
        .M02_AXI_wdata(smartconnect_1_M02_AXI_WDATA),
        .M02_AXI_wready(smartconnect_1_M02_AXI_WREADY),
        .M02_AXI_wvalid(smartconnect_1_M02_AXI_WVALID),
        .M03_AXI_araddr(smartconnect_1_M03_AXI_ARADDR),
        .M03_AXI_arready(smartconnect_1_M03_AXI_ARREADY),
        .M03_AXI_arvalid(smartconnect_1_M03_AXI_ARVALID),
        .M03_AXI_awaddr(smartconnect_1_M03_AXI_AWADDR),
        .M03_AXI_awready(smartconnect_1_M03_AXI_AWREADY),
        .M03_AXI_awvalid(smartconnect_1_M03_AXI_AWVALID),
        .M03_AXI_bready(smartconnect_1_M03_AXI_BREADY),
        .M03_AXI_bresp(smartconnect_1_M03_AXI_BRESP),
        .M03_AXI_bvalid(smartconnect_1_M03_AXI_BVALID),
        .M03_AXI_rdata(smartconnect_1_M03_AXI_RDATA),
        .M03_AXI_rready(smartconnect_1_M03_AXI_RREADY),
        .M03_AXI_rresp(smartconnect_1_M03_AXI_RRESP),
        .M03_AXI_rvalid(smartconnect_1_M03_AXI_RVALID),
        .M03_AXI_wdata(smartconnect_1_M03_AXI_WDATA),
        .M03_AXI_wready(smartconnect_1_M03_AXI_WREADY),
        .M03_AXI_wstrb(smartconnect_1_M03_AXI_WSTRB),
        .M03_AXI_wvalid(smartconnect_1_M03_AXI_WVALID),
        .S00_AXI_araddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR),
        .S00_AXI_arburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST),
        .S00_AXI_arcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE),
        .S00_AXI_arid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID),
        .S00_AXI_arlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN),
        .S00_AXI_arlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK),
        .S00_AXI_arprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT),
        .S00_AXI_arqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS),
        .S00_AXI_arready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY),
        .S00_AXI_arsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE),
        .S00_AXI_aruser(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARUSER),
        .S00_AXI_arvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID),
        .S00_AXI_awaddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR),
        .S00_AXI_awburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST),
        .S00_AXI_awcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE),
        .S00_AXI_awid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID),
        .S00_AXI_awlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN),
        .S00_AXI_awlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK),
        .S00_AXI_awprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT),
        .S00_AXI_awqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS),
        .S00_AXI_awready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY),
        .S00_AXI_awsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE),
        .S00_AXI_awuser(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWUSER),
        .S00_AXI_awvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID),
        .S00_AXI_bid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID),
        .S00_AXI_bready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY),
        .S00_AXI_bresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP),
        .S00_AXI_bvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID),
        .S00_AXI_rdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA),
        .S00_AXI_rid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID),
        .S00_AXI_rlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST),
        .S00_AXI_rready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY),
        .S00_AXI_rresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP),
        .S00_AXI_rvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID),
        .S00_AXI_wdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA),
        .S00_AXI_wlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST),
        .S00_AXI_wready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY),
        .S00_AXI_wstrb(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB),
        .S00_AXI_wvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID),
        .aclk(zynq_ultra_ps_e_0_pl_clk0),
        .aresetn(rst_ps8_0_149M_peripheral_aresetn));
  design_1_zynq_ultra_ps_e_0_0 zynq_ultra_ps_e_0
       (.maxigp2_araddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR),
        .maxigp2_arburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST),
        .maxigp2_arcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE),
        .maxigp2_arid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID),
        .maxigp2_arlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN),
        .maxigp2_arlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK),
        .maxigp2_arprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT),
        .maxigp2_arqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS),
        .maxigp2_arready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY),
        .maxigp2_arsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE),
        .maxigp2_aruser(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARUSER),
        .maxigp2_arvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID),
        .maxigp2_awaddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR),
        .maxigp2_awburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST),
        .maxigp2_awcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE),
        .maxigp2_awid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID),
        .maxigp2_awlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN),
        .maxigp2_awlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK),
        .maxigp2_awprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT),
        .maxigp2_awqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS),
        .maxigp2_awready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY),
        .maxigp2_awsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE),
        .maxigp2_awuser(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWUSER),
        .maxigp2_awvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID),
        .maxigp2_bid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID),
        .maxigp2_bready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY),
        .maxigp2_bresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP),
        .maxigp2_bvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID),
        .maxigp2_rdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA),
        .maxigp2_rid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID),
        .maxigp2_rlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST),
        .maxigp2_rready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY),
        .maxigp2_rresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP),
        .maxigp2_rvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID),
        .maxigp2_wdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA),
        .maxigp2_wlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST),
        .maxigp2_wready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY),
        .maxigp2_wstrb(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB),
        .maxigp2_wvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID),
        .maxihpm0_lpd_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .pl_clk0(zynq_ultra_ps_e_0_pl_clk0),
        .pl_resetn0(zynq_ultra_ps_e_0_pl_resetn0),
        .saxigp0_araddr(ps8_0_axi_periph_M05_AXI_ARADDR),
        .saxigp0_arburst(ps8_0_axi_periph_M05_AXI_ARBURST),
        .saxigp0_arcache(ps8_0_axi_periph_M05_AXI_ARCACHE),
        .saxigp0_arid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp0_arlen(ps8_0_axi_periph_M05_AXI_ARLEN),
        .saxigp0_arlock(ps8_0_axi_periph_M05_AXI_ARLOCK),
        .saxigp0_arprot(ps8_0_axi_periph_M05_AXI_ARPROT),
        .saxigp0_arqos(ps8_0_axi_periph_M05_AXI_ARQOS),
        .saxigp0_arready(ps8_0_axi_periph_M05_AXI_ARREADY),
        .saxigp0_arsize(ps8_0_axi_periph_M05_AXI_ARSIZE),
        .saxigp0_aruser(1'b0),
        .saxigp0_arvalid(ps8_0_axi_periph_M05_AXI_ARVALID),
        .saxigp0_awaddr(ps8_0_axi_periph_M05_AXI_AWADDR),
        .saxigp0_awburst(ps8_0_axi_periph_M05_AXI_AWBURST),
        .saxigp0_awcache(ps8_0_axi_periph_M05_AXI_AWCACHE),
        .saxigp0_awid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .saxigp0_awlen(ps8_0_axi_periph_M05_AXI_AWLEN),
        .saxigp0_awlock(ps8_0_axi_periph_M05_AXI_AWLOCK),
        .saxigp0_awprot(ps8_0_axi_periph_M05_AXI_AWPROT),
        .saxigp0_awqos(ps8_0_axi_periph_M05_AXI_AWQOS),
        .saxigp0_awready(ps8_0_axi_periph_M05_AXI_AWREADY),
        .saxigp0_awsize(ps8_0_axi_periph_M05_AXI_AWSIZE),
        .saxigp0_awuser(1'b0),
        .saxigp0_awvalid(ps8_0_axi_periph_M05_AXI_AWVALID),
        .saxigp0_bready(ps8_0_axi_periph_M05_AXI_BREADY),
        .saxigp0_bresp(ps8_0_axi_periph_M05_AXI_BRESP),
        .saxigp0_bvalid(ps8_0_axi_periph_M05_AXI_BVALID),
        .saxigp0_rdata(ps8_0_axi_periph_M05_AXI_RDATA),
        .saxigp0_rlast(ps8_0_axi_periph_M05_AXI_RLAST),
        .saxigp0_rready(ps8_0_axi_periph_M05_AXI_RREADY),
        .saxigp0_rresp(ps8_0_axi_periph_M05_AXI_RRESP),
        .saxigp0_rvalid(ps8_0_axi_periph_M05_AXI_RVALID),
        .saxigp0_wdata(ps8_0_axi_periph_M05_AXI_WDATA),
        .saxigp0_wlast(ps8_0_axi_periph_M05_AXI_WLAST),
        .saxigp0_wready(ps8_0_axi_periph_M05_AXI_WREADY),
        .saxigp0_wstrb(ps8_0_axi_periph_M05_AXI_WSTRB),
        .saxigp0_wvalid(ps8_0_axi_periph_M05_AXI_WVALID),
        .saxihpc0_fpd_aclk(zynq_ultra_ps_e_0_pl_clk0));
endmodule
