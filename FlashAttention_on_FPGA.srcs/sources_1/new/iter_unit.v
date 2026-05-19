`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/28 02:52:32
// Design Name: 
// Module Name: iter_unit
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


module iter_unit #(
    parameter Q_TOKENS = 8,
    parameter HEAD_DIM = 4
)(
    input        rst_n,
    input        clk,

    input        axi_to_bram_clk,

    input[15:0]  axi_old_o_data_in,
    input        axi_old_o_we_in,
    input        axi_old_o_en_in,
    input[16:0]   axi_old_o_addr_in,

    input[15:0]  axi_old_m_data_in,
    input        axi_old_m_we_in,
    input        axi_old_m_en_in,
    input[9:0]   axi_old_m_addr_in,

    input[15:0]  axi_old_r_data_in,
    input        axi_old_r_we_in,
    input        axi_old_r_en_in,
    input[9:0]   axi_old_r_addr_in,

    input[15:0]  local_m_data_in,
    input        local_m_data_valid_in,

    input[15:0]  local_r_data_in,
    input        local_r_data_valid_in,

    input[15:0]  local_o_data_in,
    input        local_o_data_valid_in,

    input        axi_new_o_en_in,
    input[16:0]  axi_new_o_addr_in,
    output[15:0] axi_new_o_data_out,
    output       axi_new_o_valid_out,

    input        axi_new_m_en_in,
    input[9:0]   axi_new_m_addr_in,
    output[15:0] axi_new_m_data_out,
    output       axi_new_m_valid_out,

    input        axi_new_r_en_in,
    input[9:0]   axi_new_r_addr_in,
    output[15:0] axi_new_r_data_out,
    output       axi_new_r_valid_out,

    output       iter_unit_done_out
);

    reg[6:0] local_o_cnt;

    always @(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            local_o_cnt <= 0;
        end
        else
        begin
            if(local_o_data_valid_in)
            begin
                if(local_o_cnt < HEAD_DIM) local_o_cnt <= local_o_cnt + 1;
                else local_o_cnt <= 1;
            end
        end
    end

    
// m_start
    reg[9:0] local_m_write_addr_reg;
    reg[9:0] m_read_addr_reg;
    reg      m_read_en_wire;   
    wire[15:0] local_m_read_data;
    reg      m_read_en;

    bram_18kb_mem local_m_mem (
        .clka(clk),         // input wire clka
        .ena(local_m_data_valid_in),        // input wire ena
        .wea(local_m_data_valid_in),        // input wire [0 : 0] wea
        .addra(local_m_write_addr_reg),    // input wire [9 : 0] addra
        .dina(local_m_data_in),    // input wire [15 : 0] dina
        .clkb(clk),            // input wire clkb
        .enb(m_read_en),      // input wire enb
        .addrb(m_read_addr_reg),  // input wire [9 : 0] addrb
        .doutb(local_m_read_data)     // output wire [15 : 0] doutb
    );

    wire[15:0] old_m_read_data;

    bram_18kb_mem old_m_mem (
        .clka(axi_to_bram_clk),         // input wire clka
        .ena(axi_old_m_en_in),        // input wire ena
        .wea(axi_old_m_we_in),        // input wire [0 : 0] wea
        .addra(axi_old_m_addr_in),    // input wire [9 : 0] addra
        .dina(axi_old_m_data_in),    // input wire [15 : 0] dina
        .clkb(clk),            // input wire clkb
        .enb(m_read_en),      // input wire enb
        .addrb({old_m_pingpang_mode_reg, m_read_addr_reg[8:0]}),  // input wire [9 : 0] addrb
        .doutb(old_m_read_data)     // output wire [15 : 0] doutb
    );

    always@(*)
    begin
        m_read_en_wire = (local_o_data_valid_in && (local_o_cnt == HEAD_DIM||local_o_cnt == 0));
        m_read_en = m_read_en_wire || m_read_en_reg1;
    end

    reg old_m_pingpang_mode_reg;

    always@(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            local_m_write_addr_reg <= 0;
            m_read_addr_reg <= 0;
            old_m_pingpang_mode_reg <= 0;
        end 
        else      
        begin
            if(local_m_data_valid_in)
            begin
                if(local_m_write_addr_reg < Q_TOKENS-1) local_m_write_addr_reg <= local_m_write_addr_reg + 1;
                else local_m_write_addr_reg <= 0;
            end
            else local_m_write_addr_reg <= local_m_write_addr_reg;

            if(local_o_data_valid_in && (local_o_cnt == HEAD_DIM||local_o_cnt == 0)) 
            begin
                if(m_read_addr_reg < Q_TOKENS-1) 
                begin
                    m_read_addr_reg <= m_read_addr_reg + 1;
                    old_m_pingpang_mode_reg <= old_m_pingpang_mode_reg;
                end
                else 
                begin
                    m_read_addr_reg <= 0;
                    old_m_pingpang_mode_reg <= ~old_m_pingpang_mode_reg;
                end
            end
            else 
            begin
                m_read_addr_reg <= m_read_addr_reg;
                old_m_pingpang_mode_reg <= old_m_pingpang_mode_reg;
            end
            
                
        end          
    end

    reg m_read_en_reg1;
    reg m_read_en_reg2;
    reg[15:0] local_m_reg1;
    reg[15:0] old_m_reg1;

    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n) 
        begin
            m_read_en_reg1 <= 0;
            m_read_en_reg2 <= 0;
            local_m_reg1 <= 0;
            old_m_reg1 <= 0;
        end
        else
        begin
            m_read_en_reg1 <= m_read_en_wire;
            m_read_en_reg2 <= m_read_en_reg1;
            local_m_reg1 <= local_m_read_data;
            old_m_reg1 <= old_m_read_data;
        end     
    end
//m end

//r start
    reg[9:0] local_r_write_addr_reg;
    reg[9:0] r_read_addr_reg;
    reg r_read_en_wire;
    wire[15:0] local_r_read_data;

    bram_18kb_mem local_r_mem (
        .clka(clk),         // input wire clka
        .ena(local_r_data_valid_in),        // input wire ena
        .wea(local_r_data_valid_in),        // input wire [0 : 0] wea
        .addra(local_r_write_addr_reg),    // input wire [9 : 0] addra
        .dina(local_r_data_in),    // input wire [15 : 0] dina
        .clkb(clk),            // input wire clkb
        .enb(r_read_en),      // input wire enb
        .addrb(r_read_addr_reg),  // input wire [9 : 0] addrb
        .doutb(local_r_read_data)     // output wire [15 : 0] doutb
    );

    wire[15:0] old_r_read_data;
    reg r_read_en;

    bram_18kb_mem old_r_mem (
        .clka(axi_to_bram_clk),         // input wire clka
        .ena(axi_old_r_en_in),        // input wire ena
        .wea(axi_old_r_we_in),        // input wire [0 : 0] wea
        .addra(axi_old_r_addr_in),    // input wire [9 : 0] addra
        .dina(axi_old_r_data_in),    // input wire [15 : 0] dina
        .clkb(clk),            // input wire clkb
        .enb(r_read_en),      // input wire enb
        .addrb({old_r_pingpang_mode_reg, r_read_addr_reg[8:0]}),  // input wire [9 : 0] addrb
        .doutb(old_r_read_data)     // output wire [15 : 0] doutb
    );

    reg r_read_en_reg1;

    always@(*) 
    begin
        r_read_en_wire = (local_o_data_valid_in && (local_o_cnt == HEAD_DIM||local_o_cnt == 0));
        r_read_en = r_read_en_wire || r_read_en_reg1;
    end
    
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) r_read_en_reg1 <= 0;
        else r_read_en_reg1 <= r_read_en_wire;
    end

    reg old_r_pingpang_mode_reg;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            local_r_write_addr_reg <= 0;
            r_read_addr_reg <= 0;
            old_r_pingpang_mode_reg <= 0;
        end 
        else      
        begin
            if(local_r_data_valid_in)
            begin
                if(local_r_write_addr_reg < Q_TOKENS-1)local_r_write_addr_reg <= local_r_write_addr_reg + 1;
                else local_r_write_addr_reg <= 0;
            end
            else local_r_write_addr_reg <= local_r_write_addr_reg;

            if(local_o_data_valid_in && (local_o_cnt == HEAD_DIM||local_o_cnt == 0)) 
            begin
                if(r_read_addr_reg < Q_TOKENS-1)
                begin
                    r_read_addr_reg <= r_read_addr_reg + 1;
                    old_r_pingpang_mode_reg <= old_r_pingpang_mode_reg;
                end 
                else 
                begin
                    r_read_addr_reg <= 0;
                    old_r_pingpang_mode_reg <= ~old_r_pingpang_mode_reg;
                end
            end
            else 
            begin
                r_read_addr_reg <= r_read_addr_reg;
                old_r_pingpang_mode_reg <= old_r_pingpang_mode_reg;
            end
        end          
    end
    reg[15:0] local_r_reg1;
    reg[15:0] local_r_reg2;
    reg[15:0] local_r_reg3;
    reg[15:0] local_r_reg4;
    reg[15:0] local_r_reg5;
    reg[15:0] local_r_reg6;
    reg[15:0] local_r_reg7;
    reg[15:0] local_r_reg8;
    
    reg[15:0] old_r_reg1;
    reg[15:0] old_r_reg2;
    reg[15:0] old_r_reg3;
    reg[15:0] old_r_reg4;
    reg[15:0] old_r_reg5;
    reg[15:0] old_r_reg6;
    reg[15:0] old_r_reg7;
    reg[15:0] old_r_reg8;

    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n)
        begin
            local_r_reg1 <= 0;
            local_r_reg2 <= 0;  
            local_r_reg3 <= 0;
            local_r_reg4 <= 0;
            local_r_reg5 <= 0;
            local_r_reg6 <= 0;
            local_r_reg7 <= 0;
            local_r_reg8 <= 0;

            old_r_reg1 <= 0;
            old_r_reg2 <= 0;       
            old_r_reg3 <= 0;
            old_r_reg4 <= 0;
            old_r_reg5 <= 0;
            old_r_reg6 <= 0;
            old_r_reg7 <= 0;
            old_r_reg8 <= 0;
        end
        else
        begin            
            local_r_reg1 <= local_r_read_data;
            local_r_reg2 <= local_r_reg1;
            local_r_reg3 <= local_r_reg2;
            local_r_reg4 <= local_r_reg3;
            local_r_reg5 <= local_r_reg4;
            local_r_reg6 <= local_r_reg5;
            local_r_reg7 <= local_r_reg6;
            local_r_reg8 <= local_r_reg7;

            old_r_reg1 <= old_r_read_data;
            old_r_reg2 <= old_r_reg1;
            old_r_reg3 <= old_r_reg2;
            old_r_reg4 <= old_r_reg3;
            old_r_reg5 <= old_r_reg4;
            old_r_reg6 <= old_r_reg5;   
            old_r_reg7 <= old_r_reg6;
            old_r_reg8 <= old_r_reg7;
        end
    end
//r end

//o start
    reg[15:0] old_o_read_addr_reg;
    wire[15:0] old_o_read_data;
    reg local_o_read_en;

    bram_60x36kb_mem old_o_mem (
        .clka(axi_to_bram_clk),         // input wire clka
        .ena(axi_old_o_en_in),        // input wire ena
        .wea(axi_old_o_we_in),        // input wire [0 : 0] wea
        .addra(axi_old_o_addr_in),    // input wire [16 : 0] addra
        .dina(axi_old_o_data_in),    // input wire [15 : 0] dina
        .clkb(clk),            // input wire clkb
        .enb(local_o_read_en),      // input wire enb
        .addrb({old_o_pingpang_mode_reg, old_o_read_addr_reg}),  // input wire [16 : 0] addrb
        .doutb(old_o_read_data)     // output wire [15 : 0] doutb
    );

    reg o_read_en_reg1;
    reg old_o_pingpang_mode_reg;

    always @(*) local_o_read_en = local_o_data_valid_in||o_read_en_reg1;
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) o_read_en_reg1 <= 0;
        else o_read_en_reg1 <= local_o_data_valid_in;
    end

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            old_o_read_addr_reg <= 0;
            old_o_pingpang_mode_reg <= 0;
        end
        else
        begin
            if(local_o_data_valid_in) 
            begin
                if(old_o_read_addr_reg < Q_TOKENS*HEAD_DIM-1)
                begin
                    old_o_read_addr_reg <= old_o_read_addr_reg + 1;
                    old_o_pingpang_mode_reg <= old_o_pingpang_mode_reg;
                end 
                else 
                begin
                    old_o_read_addr_reg <= 0;
                    old_o_pingpang_mode_reg <= ~old_o_pingpang_mode_reg;
                end
            end
            else 
            begin
                old_o_read_addr_reg <= old_o_read_addr_reg;
                old_o_pingpang_mode_reg <= old_o_pingpang_mode_reg;
            end
        end
    end

    reg[15:0] local_o_reg1;
    reg[15:0] local_o_reg2;
    reg[15:0] local_o_reg3;
    reg[15:0] local_o_reg4;
    reg[15:0] local_o_reg5;
    reg[15:0] local_o_reg6;
    reg[15:0] local_o_reg7;
    reg[15:0] local_o_reg8;
    reg[15:0] local_o_reg9;
    reg[15:0] local_o_reg10;
    reg[15:0] local_o_reg11;

    reg local_o_valid_reg1;
    reg local_o_valid_reg2;
    reg local_o_valid_reg3;
    reg local_o_valid_reg4;
    reg local_o_valid_reg5;
    reg local_o_valid_reg6;
    reg local_o_valid_reg7;
    reg local_o_valid_reg8;
    reg local_o_valid_reg9;
    reg local_o_valid_reg10;
    reg local_o_valid_reg11;
    
    reg[15:0] old_o_reg1;
    reg[15:0] old_o_reg2;
    reg[15:0] old_o_reg3;
    reg[15:0] old_o_reg4;
    reg[15:0] old_o_reg5;
    reg[15:0] old_o_reg6;
    reg[15:0] old_o_reg7;
    reg[15:0] old_o_reg8;
    reg[15:0] old_o_reg9;

    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n)
        begin
            local_o_reg1 <= 0;
            local_o_reg2 <= 0;
            local_o_reg3 <= 0;
            local_o_reg4 <= 0;
            local_o_reg5 <= 0;          
            local_o_reg6 <= 0;
            local_o_reg7 <= 0;
            local_o_reg8 <= 0;
            local_o_reg9 <= 0;
            local_o_reg10 <= 0;
            local_o_reg11 <= 0;

            local_o_valid_reg1 <= 0;
            local_o_valid_reg2 <= 0;
            local_o_valid_reg3 <= 0;
            local_o_valid_reg4 <= 0;
            local_o_valid_reg5 <= 0;
            local_o_valid_reg6 <= 0;
            local_o_valid_reg7 <= 0;
            local_o_valid_reg8 <= 0;
            local_o_valid_reg9 <= 0;
            local_o_valid_reg10 <= 0;
            local_o_valid_reg11 <= 0;

            old_o_reg1 <= 0;
            old_o_reg2 <= 0;       
            old_o_reg3 <= 0;
            old_o_reg4 <= 0;
            old_o_reg5 <= 0;
            old_o_reg6 <= 0;
            old_o_reg7 <= 0;
            old_o_reg8 <= 0;
            old_o_reg9 <= 0;

        end
        else
        begin            
            local_o_reg1 <= local_o_data_in;
            local_o_reg2 <= local_o_reg1;
            local_o_reg3 <= local_o_reg2;
            local_o_reg4 <= local_o_reg3;
            local_o_reg5 <= local_o_reg4;
            local_o_reg6 <= local_o_reg5;
            local_o_reg7 <= local_o_reg6;
            local_o_reg8 <= local_o_reg7;
            local_o_reg9 <= local_o_reg8;
            local_o_reg10 <= local_o_reg9;
            local_o_reg11 <= local_o_reg10;

            local_o_valid_reg1 <= local_o_data_valid_in;
            local_o_valid_reg2 <= local_o_valid_reg1;
            local_o_valid_reg3 <= local_o_valid_reg2;
            local_o_valid_reg4 <= local_o_valid_reg3;
            local_o_valid_reg5 <= local_o_valid_reg4;
            local_o_valid_reg6 <= local_o_valid_reg5;
            local_o_valid_reg7 <= local_o_valid_reg6;
            local_o_valid_reg8 <= local_o_valid_reg7;
            local_o_valid_reg9 <= local_o_valid_reg8;
            local_o_valid_reg10 <= local_o_valid_reg9;
            local_o_valid_reg11 <= local_o_valid_reg10;

            old_o_reg1 <= old_o_read_data;
            old_o_reg2 <= old_o_reg1;
            old_o_reg3 <= old_o_reg2;
            old_o_reg4 <= old_o_reg3;
            old_o_reg5 <= old_o_reg4;
            old_o_reg6 <= old_o_reg5;   
            old_o_reg7 <= old_o_reg6;
            old_o_reg8 <= old_o_reg7;
            old_o_reg9 <= old_o_reg8;
        end
    end
//o end

    wire m_sub_valid;
    wire[15:0] m_sub_result;

    fp16_sub local_m_sub_old_m (
        .aclk(clk),
        .s_axis_a_tvalid(m_read_en_reg2),
        .s_axis_a_tdata (local_m_read_data),
        .s_axis_b_tvalid(m_read_en_reg2),
        .s_axis_b_tdata (old_m_read_data),
        .m_axis_result_tvalid(m_sub_valid),
        .m_axis_result_tdata (m_sub_result)
    );

    reg m_cmp_result_reg1;
    reg m_cmp_result_reg2;
    reg m_cmp_result_reg3;
    reg m_cmp_result_reg4;
    reg m_cmp_result_reg5;
    reg m_cmp_result_reg6;
    reg m_cmp_result_reg7;
    reg m_cmp_result_reg8;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            m_cmp_result_reg1<=0;
            m_cmp_result_reg2<=0;
            m_cmp_result_reg3<=0;
            m_cmp_result_reg4<=0;
            m_cmp_result_reg5<=0;
            m_cmp_result_reg6<=0;
            m_cmp_result_reg7<=0;
            m_cmp_result_reg8<=0;
        end
        else 
        begin
            if(m_sub_valid) m_cmp_result_reg1 <= m_sub_result[15];
            else m_cmp_result_reg1 <= m_cmp_result_reg1;

            m_cmp_result_reg2 <= m_cmp_result_reg1; 
            m_cmp_result_reg3 <= m_cmp_result_reg2;
            m_cmp_result_reg4 <= m_cmp_result_reg3;
            m_cmp_result_reg5 <= m_cmp_result_reg4;
            m_cmp_result_reg6 <= m_cmp_result_reg5;
            m_cmp_result_reg7 <= m_cmp_result_reg6;
            m_cmp_result_reg8 <= m_cmp_result_reg7;
        end
    end
    
    wire scale_valid;
    wire[15:0] scale_data_out;

    fp16_exp u_exp (
        .aclk(clk),
        .s_axis_a_tvalid(m_sub_valid),
        .s_axis_a_tdata ({1'h1, m_sub_result[14:0]}),
        .m_axis_result_tvalid(scale_valid),
        .m_axis_result_tdata (scale_data_out)
    );

    reg[15:0] scale_data_reg;
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n) scale_data_reg <= 0;
        else if(scale_valid) scale_data_reg <= scale_data_out;
        else scale_data_reg <= scale_data_reg;
    end

    reg[15:0] r_data_need_scale;
    wire       r_data_scaled_valid;
    wire[15:0] r_data_scaled;

    fp16_multiply r_scale (
        .aclk                (clk),

        .s_axis_a_tvalid     (scale_valid),
        .s_axis_a_tdata      (scale_data_out),

        .s_axis_b_tvalid     (scale_valid),
        .s_axis_b_tdata      (r_data_need_scale),

        .m_axis_result_tvalid(r_data_scaled_valid),
        .m_axis_result_tdata (r_data_scaled)
    );


    reg[15:0] o_data_need_scale;
    wire       o_data_scaled_valid;
    wire[15:0] o_data_scaled;


    fp16_multiply o_scale (
        .aclk                (clk),

        .s_axis_a_tvalid     (local_o_valid_reg11),
        .s_axis_a_tdata      (scale_data_reg),

        .s_axis_b_tvalid     (local_o_valid_reg11),
        .s_axis_b_tdata      (o_data_need_scale),

        .m_axis_result_tvalid(o_data_scaled_valid),
        .m_axis_result_tdata (o_data_scaled)
    );

    always@(*)
    begin
        if(m_cmp_result_reg7 == 1'b1) r_data_need_scale = local_r_reg8; 
        else r_data_need_scale = old_r_reg8;

        if(m_cmp_result_reg8 == 1'b1) o_data_need_scale = local_o_reg11;
        else o_data_need_scale = old_o_reg9;
    end

    reg[15:0] r_data_reg1;
    reg[15:0] r_data_reg2;
    reg[15:0] r_data_reg3;

    reg[15:0] o_data_reg1;
    reg[15:0] o_data_reg2;
    reg[15:0] o_data_reg3;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            r_data_reg1 <= 0;
            r_data_reg2 <= 0;
            r_data_reg3 <= 0;

            o_data_reg1 <= 0;
            o_data_reg2 <= 0;
            o_data_reg3 <= 0;
        end
        else
        begin
            if(m_cmp_result_reg7 == 1'b1) r_data_reg1 <= old_r_reg8; 
            else r_data_reg1 <= local_r_reg8;

            if(m_cmp_result_reg8 == 1'b1) o_data_reg1 <= old_o_reg9;
            else o_data_reg1 <= local_o_reg11;

            r_data_reg2 <= r_data_reg1;
            r_data_reg3 <= r_data_reg2;

            o_data_reg2 <= o_data_reg1;
            o_data_reg3 <= o_data_reg2;
        end
    end

    wire[15:0]  new_r_data;
    wire        new_r_data_valid;

    fp16_add new_r_add (
        .aclk                (clk),

        .s_axis_a_tvalid     (r_data_scaled_valid),
        .s_axis_a_tdata      (r_data_scaled),

        .s_axis_b_tvalid     (r_data_scaled_valid),
        .s_axis_b_tdata      (r_data_reg3),

        .m_axis_result_tvalid(new_r_data_valid),
        .m_axis_result_tdata (new_r_data)
    );

    wire[15:0] new_o_data;
    wire       new_o_data_valid;
    
    fp16_add new_o_add (
        .aclk                (clk),

        .s_axis_a_tvalid     (o_data_scaled_valid),
        .s_axis_a_tdata      (o_data_scaled),

        .s_axis_b_tvalid     (o_data_scaled_valid),
        .s_axis_b_tdata      (o_data_reg3),

        .m_axis_result_tvalid(new_o_data_valid),
        .m_axis_result_tdata (new_o_data)
    );

    reg[15:0] new_m_wire;
    always @(*)
    begin
        if(m_sub_result[15] == 1'b1) new_m_wire = old_m_reg1; 
        else new_m_wire = local_m_reg1;
    end
    
    reg [8:0] new_m_addr_reg;
    reg       new_m_pingpang_mode_reg;

    bram_18kb_mem new_m_mem (
        .clka(clk),         // input wire clka
        .ena(m_sub_valid),        // input wire ena
        .wea(m_sub_valid),        // input wire [0 : 0] wea
        .addra({new_m_pingpang_mode_reg, new_m_addr_reg}),    // input wire [9 : 0] addra
        .dina(new_m_wire),    // input wire [15 : 0] dina
        .clkb(axi_to_bram_clk),            // input wire clkb
        .enb(axi_new_m_en_in||new_m_en_reg1),      // input wire enb
        .addrb(axi_new_m_addr_in),  // input wire [9 : 0] addrb
        .doutb(axi_new_m_data_out)     // output wire [15 : 0] doutb
    );

   

    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            new_m_addr_reg <= 0;
            new_m_pingpang_mode_reg <= 0;
        end
        else        
        begin
            if(m_sub_valid)            
            begin
                if(new_m_addr_reg < Q_TOKENS-1)
                begin
                    new_m_addr_reg <= new_m_addr_reg + 1;
                    new_m_pingpang_mode_reg <= new_m_pingpang_mode_reg;
                end
                else 
                begin
                    new_m_addr_reg <= 0;
                    new_m_pingpang_mode_reg <= ~new_m_pingpang_mode_reg;
                end
            end
            else 
            begin
                new_m_addr_reg <= new_m_addr_reg;
                new_m_pingpang_mode_reg <= new_m_pingpang_mode_reg;
            end
        end
    end

    reg[8:0] new_r_addr_reg;
    reg      new_r_pingpang_mode_reg;

    bram_18kb_mem new_r_mem (
        .clka(clk),         // input wire clka
        .ena(new_r_data_valid),        // input wire ena
        .wea(new_r_data_valid),        // input wire [0 : 0] wea
        .addra({new_r_pingpang_mode_reg, new_r_addr_reg}),    // input wire [9 : 0] addra
        .dina(new_r_data),    // input wire [15 : 0] dina
        .clkb(axi_to_bram_clk),            // input wire clkb
        .enb(axi_new_r_en_in||new_r_en_reg1),      // input wire enb
        .addrb(axi_new_r_addr_in),  // input wire [9 : 0] addrb
        .doutb(axi_new_r_data_out)     // output wire [15 : 0] doutb
    );

    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)              
        begin
            new_r_addr_reg <= 0;
            new_r_pingpang_mode_reg <= 0;
        end
        else        
        begin
            if(new_r_data_valid)            
            begin
                if(new_r_addr_reg < Q_TOKENS-1)
                begin
                    new_r_addr_reg <= new_r_addr_reg + 1;
                    new_r_pingpang_mode_reg <= new_r_pingpang_mode_reg;
                end
                else 
                begin
                    new_r_addr_reg <= 0;
                    new_r_pingpang_mode_reg <= ~new_r_pingpang_mode_reg;
                end
            end
            else 
            begin
                new_r_addr_reg <= new_r_addr_reg;
                new_r_pingpang_mode_reg <= new_r_pingpang_mode_reg;
            end
        end
    end

    reg[15:0] new_o_addr_reg; 
    reg       new_o_pingpang_mode_reg;

    bram_60x36kb_mem new_o_mem (
        .clka(clk),         
        .ena(new_o_data_valid),       
        .wea(new_o_data_valid),       
        .addra({new_o_pingpang_mode_reg, new_o_addr_reg}),   
        .dina(new_o_data),    
        .clkb(axi_to_bram_clk),           
        .enb(axi_new_o_en_in||new_o_en_reg1),     
        .addrb(axi_new_o_addr_in),  
        .doutb(axi_new_o_data_out)   
    );

   

    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            new_o_addr_reg <= 0;
            new_o_pingpang_mode_reg <= 0;
        end
        else        
        begin
            if(new_o_data_valid)            
            begin
                if(new_o_addr_reg < Q_TOKENS*HEAD_DIM-1) 
                begin
                    new_o_addr_reg <= new_o_addr_reg + 1;
                    new_o_pingpang_mode_reg <= new_o_pingpang_mode_reg;
                end
                else 
                begin
                    new_o_addr_reg <= 0;
                    new_o_pingpang_mode_reg <= ~new_o_pingpang_mode_reg;
                end
            end
            else
            begin
                new_o_addr_reg <= new_o_addr_reg;
                new_o_pingpang_mode_reg <= new_o_pingpang_mode_reg;
            end
             
        end
    end
    

    reg new_m_en_reg1;
    reg new_m_en_reg2;
    reg new_r_en_reg1;
    reg new_r_en_reg2;
    reg new_o_en_reg1;
    reg new_o_en_reg2;

    always @(posedge axi_to_bram_clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            new_m_en_reg1 <= 0;
            new_m_en_reg2 <= 0;
            new_r_en_reg1 <= 0;
            new_r_en_reg2 <= 0;
            new_o_en_reg1 <= 0;
            new_o_en_reg2 <= 0;
        end
        else
        begin
            new_m_en_reg1 <= axi_new_m_en_in;
            new_m_en_reg2 <= new_m_en_reg1;

            new_r_en_reg1 <= axi_new_r_en_in;
            new_r_en_reg2 <= new_r_en_reg1;

            new_o_en_reg1 <= axi_new_o_en_in;
            new_o_en_reg2 <= new_o_en_reg1;
        end
    end

    assign axi_new_m_valid_out = new_m_en_reg2;
    assign axi_new_r_valid_out = new_r_en_reg2;
    assign axi_new_o_valid_out = new_o_en_reg2;

    reg iter_unit_done_reg;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n) iter_unit_done_reg <= 0;
        else if(new_o_data_valid && (new_o_addr_reg == Q_TOKENS*HEAD_DIM-1)) iter_unit_done_reg <= 1;
        else iter_unit_done_reg <= 0;
    end

    assign iter_unit_done_out = iter_unit_done_reg;



endmodule
