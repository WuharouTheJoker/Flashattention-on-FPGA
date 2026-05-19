`timescale 1ns / 1ps

module head_dim_4_top_module #(
    parameter TOKENS = 1024
)(

    //================ AXI QKV INTERFACE =================
    input  wire         s_axi_qkv_aclk,
    input  wire         s_axi_qkv_aresetn,

    // Write Address
    input  wire [15:0]  s_axi_qkv_awaddr,
    input  wire [7:0]   s_axi_qkv_awlen,
    input  wire [2:0]   s_axi_qkv_awsize,
    input  wire [1:0]   s_axi_qkv_awburst,
    input  wire         s_axi_qkv_awlock,
    input  wire [3:0]   s_axi_qkv_awcache,
    input  wire [2:0]   s_axi_qkv_awprot,
    input  wire         s_axi_qkv_awvalid,
    output wire         s_axi_qkv_awready,

    // Write Data
    input  wire [31:0]  s_axi_qkv_wdata,
    input  wire [3:0]   s_axi_qkv_wstrb,
    input  wire         s_axi_qkv_wlast,
    input  wire         s_axi_qkv_wvalid,
    output wire         s_axi_qkv_wready,

    // Write Resp
    output wire [1:0]   s_axi_qkv_bresp,
    output wire         s_axi_qkv_bvalid,
    input  wire         s_axi_qkv_bready,

    // Read Address
    input  wire [15:0]  s_axi_qkv_araddr,
    input  wire [7:0]   s_axi_qkv_arlen,
    input  wire [2:0]   s_axi_qkv_arsize,
    input  wire [1:0]   s_axi_qkv_arburst,
    input  wire         s_axi_qkv_arlock,
    input  wire [3:0]   s_axi_qkv_arcache,
    input  wire [2:0]   s_axi_qkv_arprot,
    input  wire         s_axi_qkv_arvalid,
    output wire         s_axi_qkv_arready,

    // Read Data
    output wire [31:0]  s_axi_qkv_rdata,
    output wire [1:0]   s_axi_qkv_rresp,
    output wire         s_axi_qkv_rlast,
    output wire         s_axi_qkv_rvalid,
    input  wire         s_axi_qkv_rready,

    //================ AXI O INTERFACE =================
    input  wire         s_axi_o_aclk,
    input  wire         s_axi_o_aresetn,

    input  wire [17:0]  s_axi_o_awaddr,
    input  wire [7:0]   s_axi_o_awlen,
    input  wire [2:0]   s_axi_o_awsize,
    input  wire [1:0]   s_axi_o_awburst,
    input  wire         s_axi_o_awlock,
    input  wire [3:0]   s_axi_o_awcache,
    input  wire [2:0]   s_axi_o_awprot,
    input  wire         s_axi_o_awvalid,
    output wire         s_axi_o_awready,

    input  wire [31:0]  s_axi_o_wdata,
    input  wire [3:0]   s_axi_o_wstrb,
    input  wire         s_axi_o_wlast,
    input  wire         s_axi_o_wvalid,
    output wire         s_axi_o_wready,

    output wire [1:0]   s_axi_o_bresp,
    output wire         s_axi_o_bvalid,
    input  wire         s_axi_o_bready,

    input  wire [17:0]  s_axi_o_araddr,
    input  wire [7:0]   s_axi_o_arlen,
    input  wire [2:0]   s_axi_o_arsize,
    input  wire [1:0]   s_axi_o_arburst,
    input  wire         s_axi_o_arlock,
    input  wire [3:0]   s_axi_o_arcache,
    input  wire [2:0]   s_axi_o_arprot,
    input  wire         s_axi_o_arvalid,
    output wire         s_axi_o_arready,

    output wire [31:0]  s_axi_o_rdata,
    output wire [1:0]   s_axi_o_rresp,
    output wire         s_axi_o_rlast,
    output wire         s_axi_o_rvalid,
    input  wire         s_axi_o_rready,

    //================ CTRL =================
    input  wire         s_axi_ctrl_aclk,
    input  wire         s_axi_ctrl_aresetn,
    input  wire [3:0]   s_axi_ctrl_awaddr,
    input  wire [2:0]   s_axi_ctrl_awprot,
    input  wire         s_axi_ctrl_awvalid,
    output wire         s_axi_ctrl_awready,

    input  wire [31:0]  s_axi_ctrl_wdata,
    input  wire [3:0]   s_axi_ctrl_wstrb,
    input  wire         s_axi_ctrl_wvalid,
    output wire         s_axi_ctrl_wready,

    output wire [1:0]   s_axi_ctrl_bresp,
    output wire         s_axi_ctrl_bvalid,
    input  wire         s_axi_ctrl_bready,

    input  wire [3:0]   s_axi_ctrl_araddr,
    input  wire [2:0]   s_axi_ctrl_arprot,
    input  wire         s_axi_ctrl_arvalid,
    output wire         s_axi_ctrl_arready,

    output wire [31:0]  s_axi_ctrl_rdata,
    output wire [1:0]   s_axi_ctrl_rresp,
    output wire         s_axi_ctrl_rvalid,
    input  wire         s_axi_ctrl_rready,

    //================ INTC =================
    input  wire         s_axi_intc_aclk,
    input  wire         s_axi_intc_aresetn,
    input  wire [8:0]   s_axi_intc_awaddr,
    input  wire         s_axi_intc_awvalid,
    output wire         s_axi_intc_awready,

    input  wire [31:0]  s_axi_intc_wdata,
    input  wire [3:0]   s_axi_intc_wstrb,
    input  wire         s_axi_intc_wvalid,
    output wire         s_axi_intc_wready,

    output wire [1:0]   s_axi_intc_bresp,
    output wire         s_axi_intc_bvalid,
    input  wire         s_axi_intc_bready,

    input  wire [8:0]   s_axi_intc_araddr,
    input  wire         s_axi_intc_arvalid,
    output wire         s_axi_intc_arready,

    output wire [31:0]  s_axi_intc_rdata,
    output wire [1:0]   s_axi_intc_rresp,
    output wire         s_axi_intc_rvalid,
    input  wire         s_axi_intc_rready,

    output wire         irq,

    // core clk
    input  wire         clk,
    input  wire         cdma_interrupt_in,
    output wire         single_iter_done,
    output wire         all_iter_done
);

    //================ CTRL IP =================
    wire rst_n;
    wire qk_mem_array_en_in;
    wire [7:0] iter_num_in;
    wire iter_num_valid_in;

    axi_flashattention2_unit_ctrl_1 u_ctrl (
        .rst_n(rst_n),
        .qk_mem_array_en_in(qk_mem_array_en_in),
        .iter_num_in(iter_num_in),
        .iter_num_valid_in(iter_num_valid_in),

        .s00_axi_aclk(s_axi_ctrl_aclk),
        .s00_axi_aresetn(s_axi_ctrl_aresetn),
        .s00_axi_awaddr(s_axi_ctrl_awaddr),
        .s00_axi_awprot(s_axi_ctrl_awprot),
        .s00_axi_awvalid(s_axi_ctrl_awvalid),
        .s00_axi_awready(s_axi_ctrl_awready),
        .s00_axi_wdata(s_axi_ctrl_wdata),
        .s00_axi_wstrb(s_axi_ctrl_wstrb),
        .s00_axi_wvalid(s_axi_ctrl_wvalid),
        .s00_axi_wready(s_axi_ctrl_wready),
        .s00_axi_bresp(s_axi_ctrl_bresp),
        .s00_axi_bvalid(s_axi_ctrl_bvalid),
        .s00_axi_bready(s_axi_ctrl_bready),
        .s00_axi_araddr(s_axi_ctrl_araddr),
        .s00_axi_arprot(s_axi_ctrl_arprot),
        .s00_axi_arvalid(s_axi_ctrl_arvalid),
        .s00_axi_arready(s_axi_ctrl_arready),
        .s00_axi_rdata(s_axi_ctrl_rdata),
        .s00_axi_rresp(s_axi_ctrl_rresp),
        .s00_axi_rvalid(s_axi_ctrl_rvalid),
        .s00_axi_rready(s_axi_ctrl_rready)
    );

    //================ INTC =================
    wire [2:0] intr;

    axi_intc_0 u_intc (
        .s_axi_aclk(s_axi_intc_aclk),
        .s_axi_aresetn(s_axi_intc_aresetn),

        .s_axi_awaddr(s_axi_intc_awaddr),
        .s_axi_awvalid(s_axi_intc_awvalid),
        .s_axi_awready(s_axi_intc_awready),

        .s_axi_wdata(s_axi_intc_wdata),
        .s_axi_wstrb(s_axi_intc_wstrb),
        .s_axi_wvalid(s_axi_intc_wvalid),
        .s_axi_wready(s_axi_intc_wready),

        .s_axi_bresp(s_axi_intc_bresp),
        .s_axi_bvalid(s_axi_intc_bvalid),
        .s_axi_bready(s_axi_intc_bready),

        .s_axi_araddr(s_axi_intc_araddr),
        .s_axi_arvalid(s_axi_intc_arvalid),
        .s_axi_arready(s_axi_intc_arready),

        .s_axi_rdata(s_axi_intc_rdata),
        .s_axi_rresp(s_axi_intc_rresp),
        .s_axi_rvalid(s_axi_intc_rvalid),
        .s_axi_rready(s_axi_intc_rready),

        .intr(intr),
        .irq(irq)
    );

    //================ DONE SYNC =================
    wire [1:0] single_iter_done_out_bus;
    wire [1:0] all_iter_done_out_bus;

    wire single_done = single_iter_done_out_bus[0];
    wire all_done    = all_iter_done_out_bus[0];

    reg [2:0] single_sync;
    reg [2:0] all_sync;

    always @(posedge s_axi_intc_aclk or negedge s_axi_intc_aresetn) begin
        if (!s_axi_intc_aresetn) begin
            single_sync <= 3'b0;
            all_sync    <= 3'b0;
        end else begin
            single_sync <= {single_sync[1:0], single_done};
            all_sync    <= {all_sync[1:0], all_done};
        end
    end

    assign intr[0] = |single_sync;
    assign intr[1] = |all_sync;
    assign intr[2] = cdma_interrupt_in;

        //================ AXI QKV BRAM CTRL =================
    wire axi_to_bram_clk;
    wire qkv_bram_en;
    wire [3:0]  qkv_bram_we;
    wire [15:0] qkv_bram_addr;
    wire [31:0] qkv_bram_wrdata;

    axi_bram_ctrl_qkv qkv_write (
        .s_axi_aclk    (s_axi_qkv_aclk),
        .s_axi_aresetn (s_axi_qkv_aresetn),

        .s_axi_awaddr  (s_axi_qkv_awaddr),
        .s_axi_awlen   (s_axi_qkv_awlen),
        .s_axi_awsize  (s_axi_qkv_awsize),
        .s_axi_awburst (s_axi_qkv_awburst),
        .s_axi_awlock  (s_axi_qkv_awlock),
        .s_axi_awcache (s_axi_qkv_awcache),
        .s_axi_awprot  (s_axi_qkv_awprot),
        .s_axi_awvalid (s_axi_qkv_awvalid),
        .s_axi_awready (s_axi_qkv_awready),

        .s_axi_wdata   (s_axi_qkv_wdata),
        .s_axi_wstrb   (s_axi_qkv_wstrb),
        .s_axi_wlast   (s_axi_qkv_wlast),
        .s_axi_wvalid  (s_axi_qkv_wvalid),
        .s_axi_wready  (s_axi_qkv_wready),

        .s_axi_bresp   (s_axi_qkv_bresp),
        .s_axi_bvalid  (s_axi_qkv_bvalid),
        .s_axi_bready  (s_axi_qkv_bready),

        .s_axi_araddr  (s_axi_qkv_araddr),
        .s_axi_arlen   (s_axi_qkv_arlen),
        .s_axi_arsize  (s_axi_qkv_arsize),
        .s_axi_arburst (s_axi_qkv_arburst),
        .s_axi_arlock  (s_axi_qkv_arlock),
        .s_axi_arcache (s_axi_qkv_arcache),
        .s_axi_arprot  (s_axi_qkv_arprot),
        .s_axi_arvalid (s_axi_qkv_arvalid),
        .s_axi_arready (s_axi_qkv_arready),

        .s_axi_rdata   (s_axi_qkv_rdata),
        .s_axi_rresp   (s_axi_qkv_rresp),
        .s_axi_rlast   (s_axi_qkv_rlast),
        .s_axi_rvalid  (s_axi_qkv_rvalid),
        .s_axi_rready  (s_axi_qkv_rready),

        .bram_clk_a    (axi_to_bram_clk),
        .bram_en_a     (qkv_bram_en),
        .bram_we_a     (qkv_bram_we),
        .bram_addr_a   (qkv_bram_addr),
        .bram_wrdata_a (qkv_bram_wrdata),
        .bram_rddata_a (32'h0)
    );

    //================ QKV REG BUFFER =================
    reg [31:0] q_data_32bit_reg1, q_data_32bit_reg2;
    reg [31:0] q_data_32bit_reg3, q_data_32bit_reg4;
    reg [31:0] k_data_32bit_reg1, k_data_32bit_reg2;
    reg [31:0] v_data_32bit_reg1, v_data_32bit_reg2;

    reg [9:0]  q_addr_reg1, q_addr_reg2, q_addr_reg3, q_addr_reg4;
    reg [10:0] k_addr_reg1, k_addr_reg2;
    reg [10:0] v_addr_reg1, v_addr_reg2;

    reg q_en_reg1, q_en_reg2, q_en_reg3, q_en_reg4;
    reg k_en_reg1, k_en_reg2;
    reg v_en_reg1, v_en_reg2;

    reg q_we_reg1, q_we_reg2, q_we_reg3, q_we_reg4;
    reg k_we_reg1, k_we_reg2;
    reg v_we_reg1, v_we_reg2;

    always @(posedge s_axi_qkv_aclk or negedge s_axi_qkv_aresetn) begin
        if (!s_axi_qkv_aresetn) begin
            {q_data_32bit_reg1,q_data_32bit_reg2,q_data_32bit_reg3,q_data_32bit_reg4} <= 0;
            {k_data_32bit_reg1,k_data_32bit_reg2} <= 0;
            {v_data_32bit_reg1,v_data_32bit_reg2} <= 0;

            {q_en_reg1,q_en_reg2,q_en_reg3,q_en_reg4} <= 0;
            {k_en_reg1,k_en_reg2} <= 0;
            {v_en_reg1,v_en_reg2} <= 0;

            {q_we_reg1,q_we_reg2,q_we_reg3,q_we_reg4} <= 0;
            {k_we_reg1,k_we_reg2} <= 0;
            {v_we_reg1,v_we_reg2} <= 0;

        end else begin
            // Q
            q_en_reg1 <= qkv_bram_en && (qkv_bram_addr[15:14]==2'b00) && (qkv_bram_addr[3:2]==2'b00);
            q_en_reg2 <= qkv_bram_en && (qkv_bram_addr[15:14]==2'b00) && (qkv_bram_addr[3:2]==2'b01);
            q_en_reg3 <= qkv_bram_en && (qkv_bram_addr[15:14]==2'b00) && (qkv_bram_addr[3:2]==2'b10);
            q_en_reg4 <= qkv_bram_en && (qkv_bram_addr[15:14]==2'b00) && (qkv_bram_addr[3:2]==2'b11);

            q_we_reg1 <= &qkv_bram_we && (qkv_bram_addr[15:14]==2'b00) && (qkv_bram_addr[3:2]==2'b00);
            q_we_reg2 <= &qkv_bram_we && (qkv_bram_addr[15:14]==2'b00) && (qkv_bram_addr[3:2]==2'b01);
            q_we_reg3 <= &qkv_bram_we && (qkv_bram_addr[15:14]==2'b00) && (qkv_bram_addr[3:2]==2'b10);
            q_we_reg4 <= &qkv_bram_we && (qkv_bram_addr[15:14]==2'b00) && (qkv_bram_addr[3:2]==2'b11);

            q_data_32bit_reg1 <= qkv_bram_wrdata;
            q_data_32bit_reg2 <= qkv_bram_wrdata;
            q_data_32bit_reg3 <= qkv_bram_wrdata;
            q_data_32bit_reg4 <= qkv_bram_wrdata;

            q_addr_reg1 <= qkv_bram_addr[13:4];
            q_addr_reg2 <= qkv_bram_addr[13:4];
            q_addr_reg3 <= qkv_bram_addr[13:4];
            q_addr_reg4 <= qkv_bram_addr[13:4];

            // K
            k_en_reg1 <= qkv_bram_en && (qkv_bram_addr[15:14]==2'b01) && (qkv_bram_addr[2]==1'b0);
            k_en_reg2 <= qkv_bram_en && (qkv_bram_addr[15:14]==2'b01) && (qkv_bram_addr[2]==1'b1);

            k_we_reg1 <= &qkv_bram_we && (qkv_bram_addr[15:14]==2'b01) && (qkv_bram_addr[2]==1'b0);
            k_we_reg2 <= &qkv_bram_we && (qkv_bram_addr[15:14]==2'b01) && (qkv_bram_addr[2]==1'b1);

            k_data_32bit_reg1 <= qkv_bram_wrdata;
            k_data_32bit_reg2 <= qkv_bram_wrdata;

            k_addr_reg1 <= qkv_bram_addr[13:3];
            k_addr_reg2 <= qkv_bram_addr[13:3];

            // V
            v_en_reg1 <= qkv_bram_en && (qkv_bram_addr[15:14]==2'b10) && (qkv_bram_addr[2]==1'b0);
            v_en_reg2 <= qkv_bram_en && (qkv_bram_addr[15:14]==2'b10) && (qkv_bram_addr[2]==1'b1);

            v_we_reg1 <= &qkv_bram_we && (qkv_bram_addr[15:14]==2'b10) && (qkv_bram_addr[2]==1'b0);
            v_we_reg2 <= &qkv_bram_we && (qkv_bram_addr[15:14]==2'b10) && (qkv_bram_addr[2]==1'b1);

            v_data_32bit_reg1 <= qkv_bram_wrdata;
            v_data_32bit_reg2 <= qkv_bram_wrdata;

            v_addr_reg1 <= qkv_bram_addr[13:3];
            v_addr_reg2 <= qkv_bram_addr[13:3];
        end
    end

    //================ O BRAM READ =================
    wire bram_to_axi_clk;
    wire o_bram_en;
    wire [17:0] o_bram_addr;
    wire [31:0] o_bram_rddata;

    axi_bram_ctrl_o o_read (
        .s_axi_aclk    (s_axi_o_aclk),
        .s_axi_aresetn (s_axi_o_aresetn),

        .s_axi_awaddr  (s_axi_o_awaddr),
        .s_axi_awlen   (s_axi_o_awlen),
        .s_axi_awsize  (s_axi_o_awsize),
        .s_axi_awburst (s_axi_o_awburst),
        .s_axi_awlock  (s_axi_o_awlock),
        .s_axi_awcache (s_axi_o_awcache),
        .s_axi_awprot  (s_axi_o_awprot),
        .s_axi_awvalid (s_axi_o_awvalid),
        .s_axi_awready (s_axi_o_awready),

        .s_axi_wdata   (s_axi_o_wdata),
        .s_axi_wstrb   (s_axi_o_wstrb),
        .s_axi_wlast   (s_axi_o_wlast),
        .s_axi_wvalid  (s_axi_o_wvalid),
        .s_axi_wready  (s_axi_o_wready),

        .s_axi_bresp   (s_axi_o_bresp),
        .s_axi_bvalid  (s_axi_o_bvalid),
        .s_axi_bready  (s_axi_o_bready),

        .s_axi_araddr  (s_axi_o_araddr),
        .s_axi_arlen   (s_axi_o_arlen),
        .s_axi_arsize  (s_axi_o_arsize),
        .s_axi_arburst (s_axi_o_arburst),
        .s_axi_arlock  (s_axi_o_arlock),
        .s_axi_arcache (s_axi_o_arcache),
        .s_axi_arprot  (s_axi_o_arprot),
        .s_axi_arvalid (s_axi_o_arvalid),
        .s_axi_arready (s_axi_o_arready),

        .s_axi_rdata   (s_axi_o_rdata),
        .s_axi_rresp   (s_axi_o_rresp),
        .s_axi_rlast   (s_axi_o_rlast),
        .s_axi_rvalid  (s_axi_o_rvalid),
        .s_axi_rready  (s_axi_o_rready),

        .bram_clk_a    (bram_to_axi_clk),
        .bram_en_a     (o_bram_en),
        .bram_addr_a   (o_bram_addr),
        .bram_rddata_a (o_bram_rddata)
    );

    //================ CORE =================
    flashattention2_with_bram_unit #(
        .TOKENS(TOKENS),
        .HEAD_DIM(4),
        .Q_TILES(2),
        .inv_sqrt_head_dim(16'h3800)
    ) dut (
        .clk(clk),
        .axi_to_bram_clk(axi_to_bram_clk),
        .bram_to_axi_clk(bram_to_axi_clk),
        .rst_n(rst_n),

        .qk_mem_array_en_in(qk_mem_array_en_in),
        .iter_num_in(iter_num_in),
        .iter_num_valid_in(iter_num_valid_in),

        .axi_k_data_in_bus({k_data_32bit_reg2,k_data_32bit_reg1}),
        .axi_k_we_in_bus({k_we_reg2,k_we_reg2,k_we_reg1,k_we_reg1}),
        .axi_k_en_in_bus({k_en_reg2,k_en_reg2,k_en_reg1,k_en_reg1}),
        .axi_k_addr_in_bus({k_addr_reg2,k_addr_reg2,k_addr_reg1,k_addr_reg1}),

        .axi_q_data_in_bus({q_data_32bit_reg4,q_data_32bit_reg3,q_data_32bit_reg2,q_data_32bit_reg1}),
        .axi_q_we_in_bus({q_we_reg4,q_we_reg4,q_we_reg3,q_we_reg3,q_we_reg2,q_we_reg2,q_we_reg1,q_we_reg1}),
        .axi_q_en_in_bus({q_en_reg4,q_en_reg4,q_en_reg3,q_en_reg3,q_en_reg2,q_en_reg2,q_en_reg1,q_en_reg1}),
        .axi_q_addr_in_bus({q_addr_reg4,q_addr_reg4,q_addr_reg3,q_addr_reg3,q_addr_reg2,q_addr_reg2,q_addr_reg1,q_addr_reg1}),

        .axi_v_data_in_bus({v_data_32bit_reg2,v_data_32bit_reg1}),
        .axi_v_we_in_bus({v_we_reg2,v_we_reg2,v_we_reg1,v_we_reg1}),
        .axi_v_en_in_bus({v_en_reg2,v_en_reg2,v_en_reg1,v_en_reg1}),
        .axi_v_addr_in_bus({v_addr_reg2,v_addr_reg2,v_addr_reg1,v_addr_reg1}),

        .o_result_read_en_in_bus({o_bram_en,o_bram_en}),
        .o_result_read_addr_in_bus({o_bram_addr[17:2],o_bram_addr[17:2]}),
        .o_result_read_data_out_bus(o_bram_rddata),

        .single_iter_done_out_bus(single_iter_done_out_bus),
        .all_iter_done_out_bus(all_iter_done_out_bus)
    );

    assign single_iter_done = single_iter_done_out_bus[0];
    assign all_iter_done    = all_iter_done_out_bus[0];

endmodule