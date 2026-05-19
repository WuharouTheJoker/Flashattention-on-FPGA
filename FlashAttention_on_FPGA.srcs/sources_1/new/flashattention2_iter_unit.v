`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/08 18:39:53
// Design Name: 
// Module Name: flashattention2_iter_unit
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


module flashattention2_iter_unit #(
    parameter Q_TOKENS = 8,
    parameter HEAD_DIM = 4
)(
    input        rst_n,
    input        clk,

    input[7:0]   iter_num_in,
    input        iter_num_valid_in,

    input[15:0]  local_m_data_in,
    input        local_m_data_valid_in,

    input[15:0]  local_r_data_in,
    input        local_r_data_valid_in,

    input[15:0]  local_o_data_in,
    input        local_o_data_valid_in,

    input        bram_to_axi_clk,
    input        o_result_read_en_in,
    input[15:0]  o_result_read_addr_in,
    output[15:0] o_result_read_data_out,
    output       o_result_read_valid_out,

    output       single_iter_done_out,
    output       all_iter_done_out
);  
    reg[7:0] iter_num_reg;

    always @(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            iter_num_reg <= 0;
        end
        else 
        begin
            if(iter_num_valid_in) iter_num_reg <= iter_num_in;
        end
    end

//m begin
    wire[15:0] old_m_read_data;

    bram_18kb_mem m_mem (
        .clka(clk),         // input wire clka
        .ena(new_m_write_en_wire),        // input wire ena
        .wea(new_m_write_en_wire),        // input wire [0 : 0] wea
        .addra(new_m_write_addr_reg),    // input wire [9 : 0] addra
        .dina(new_m_write_data_wire),    // input wire [15 : 0] dina
        .clkb(clk),            // input wire clkb
        .enb(old_m_read_en_wire),      // input wire enb
        .addrb(old_m_read_addr_reg),  // input wire [9 : 0] addrb
        .doutb(old_m_read_data)     // output wire [15 : 0] doutb
    );

    reg[15:0] local_m_reg1;
    reg[15:0] local_m_reg2;
    reg[15:0] local_m_reg3;
    reg[15:0] old_m_reg1;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            local_m_reg1 <= 0;
            local_m_reg2 <= 0;
            local_m_reg3 <= 0;
            old_m_reg1 <= 0;
        end
        else 
        begin
            local_m_reg1 <= local_m_data_in;
            local_m_reg2 <= local_m_reg1;
            local_m_reg3 <= local_m_reg2;
            old_m_reg1 <= old_m_read_data;
        end
    end
    
    reg[9:0] old_m_read_addr_reg;
    reg local_m_valid_reg1;
    reg local_m_valid_reg2;

    always@(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            old_m_read_addr_reg <= 0;
            local_m_valid_reg1 <= 0;
            local_m_valid_reg2 <= 0;
        end 
        else      
        begin
            if(local_m_data_valid_in)
            begin
                if(old_m_read_addr_reg < Q_TOKENS-1) old_m_read_addr_reg <= old_m_read_addr_reg + 1;
                else old_m_read_addr_reg <= 0;
            end
            else old_m_read_addr_reg <= old_m_read_addr_reg;
            local_m_valid_reg1 <= local_m_data_valid_in;
            local_m_valid_reg2 <= local_m_valid_reg1;
        end          
    end

    reg old_m_read_en_wire;

    always @(*) old_m_read_en_wire = local_m_data_valid_in || local_m_valid_reg1;

    wire m_sub_valid;
    wire[15:0] m_sub_result;


    fp16_sub local_m_sub_old_m (
        .aclk(clk),
        .s_axis_a_tvalid(local_m_valid_reg2),
        .s_axis_a_tdata (local_m_reg2),
        .s_axis_b_tvalid(local_m_valid_reg2),
        .s_axis_b_tdata (old_m_read_data),
        .m_axis_result_tvalid(m_sub_valid),
        .m_axis_result_tdata (m_sub_result)
    );

    reg new_m_write_en_wire;
    reg[15:0] new_m_write_data_wire;

    always @(*) 
    begin
        new_m_write_en_wire = m_sub_valid;
        if(m_iter_cnt == 0) new_m_write_data_wire = local_m_reg3;
        else if(m_sub_result[15] == 0) new_m_write_data_wire = local_m_reg3;
        else new_m_write_data_wire = old_m_reg1;
    end

    reg[9:0] new_m_write_addr_reg;
    reg[7:0] m_iter_cnt;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            new_m_write_addr_reg <= 0;
            m_iter_cnt <= 0;
        end
        else        
        begin
            if(m_sub_valid)
            begin
                if(new_m_write_addr_reg < Q_TOKENS - 1)  new_m_write_addr_reg <= new_m_write_addr_reg + 1;
                else if(m_iter_cnt < iter_num_reg-1)
                begin
                    m_iter_cnt <= m_iter_cnt + 1;
                    new_m_write_addr_reg <= 0;
                end
                else
                begin
                    m_iter_cnt <= 0;
                    new_m_write_addr_reg <= 0;
                end
            end
        end
    end

    wire scale_valid;
    wire[15:0] scale_data;

    fp16_exp get_scale_data (
        .aclk(clk),
        .s_axis_a_tvalid(m_sub_valid),
        .s_axis_a_tdata ({1'h1, m_sub_result[14:0]}),
        .m_axis_result_tvalid(scale_valid),
        .m_axis_result_tdata (scale_data)
    );

    reg m_cmp_result_reg1;
    reg m_cmp_result_reg2;
    reg m_cmp_result_reg3;
    reg m_cmp_result_reg4;
    reg m_cmp_result_reg5;
    reg m_cmp_result_reg6;
    reg m_cmp_result_reg7;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            m_cmp_result_reg1 <= 0; 
            m_cmp_result_reg2 <= 0;
            m_cmp_result_reg3 <= 0;
            m_cmp_result_reg4 <= 0;
            m_cmp_result_reg5 <= 0;
            m_cmp_result_reg6 <= 0;
            m_cmp_result_reg7 <= 0;
        end
        else
        begin
            m_cmp_result_reg1 <= m_sub_result[15];
            m_cmp_result_reg2 <= m_cmp_result_reg1;
            m_cmp_result_reg3 <= m_cmp_result_reg2;
            m_cmp_result_reg4 <= m_cmp_result_reg3;
            m_cmp_result_reg5 <= m_cmp_result_reg4;
            m_cmp_result_reg6 <= m_cmp_result_reg5;
            m_cmp_result_reg7 <= m_cmp_result_reg6;
        end
    end

    reg[9:0] scale_data_write_addr_reg;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            scale_data_write_addr_reg <= 0;
        end
        else        
        begin
            if(scale_valid)            
            begin
                if(scale_data_write_addr_reg < Q_TOKENS - 1) scale_data_write_addr_reg <= scale_data_write_addr_reg + 1;
                else scale_data_write_addr_reg <= 0;
            end
        end
    end

//m end

//r begin

    wire[15:0] old_r_read_data;

    bram_18kb_mem r_temp_mem (
        .clka(clk),         // input wire clka
        .ena(new_r_write_en_wire),        // input wire ena
        .wea(new_r_write_en_wire),        // input wire [0 : 0] wea
        .addra(new_r_write_addr_reg),    // input wire [9 : 0] addra
        .dina(new_r_write_data_wire),    // input wire [15 : 0] dina
        .clkb(clk),            // input wire clkb
        .enb(old_r_read_en_wire),      // input wire enb
        .addrb(old_r_read_addr_reg),  // input wire [9 : 0] addrb
        .doutb(old_r_read_data)     // output wire [15 : 0] doutb
    );

    
    reg[9:0] old_r_read_addr_reg;
    reg[9:0] scale_data_for_r_read_addr_reg;
    reg local_r_valid_reg1;
    reg local_r_valid_reg2;

    always@(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            old_r_read_addr_reg <= 0;
            scale_data_for_r_read_addr_reg <= 0;
            local_r_valid_reg1 <= 0;
            local_r_valid_reg2 <= 0;
        end 
        else      
        begin
            if(local_r_data_valid_in)
            begin
                if(old_r_read_addr_reg < Q_TOKENS-1) 
                begin 
                    old_r_read_addr_reg <= old_r_read_addr_reg + 1;
                    scale_data_for_r_read_addr_reg <= scale_data_for_r_read_addr_reg + 1;
                end
                else 
                begin
                    old_r_read_addr_reg <= 0;
                    scale_data_for_r_read_addr_reg <= 0;
                end
            end
            else old_r_read_addr_reg <= old_r_read_addr_reg;
            local_r_valid_reg1 <= local_r_data_valid_in;
            local_r_valid_reg2 <= local_r_valid_reg1;
        end          
    end

    reg old_r_read_en_wire;
    reg scale_data_for_r_read_en_wire;

    always @(*) 
    begin
        old_r_read_en_wire = local_r_data_valid_in || local_r_valid_reg1;
        scale_data_for_r_read_en_wire = local_r_data_valid_in || local_r_valid_reg1;
    end


    reg[15:0] local_r_reg1;
    reg[15:0] local_r_reg2;
    reg[15:0] local_r_reg3;
    reg[15:0] local_r_reg4;
    reg[15:0] local_r_reg5;
    reg[15:0] local_r_reg6;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            local_r_reg1 <= 0;          
            local_r_reg2 <= 0;
            local_r_reg3 <= 0;
            local_r_reg4 <= 0;
            local_r_reg5 <= 0;
            local_r_reg6 <= 0;
        end
        else 
        begin
            local_r_reg1 <= local_r_data_in;
            local_r_reg2 <= local_r_reg1;   
            local_r_reg3 <= local_r_reg2;
            local_r_reg4 <= local_r_reg3;
            local_r_reg5 <= local_r_reg4;
            local_r_reg6 <= local_r_reg5;
        end
    end

    wire[16:0] scale_data_for_r;

    bram_18kb_17bit_mem scale_data_for_r_mem(
        .clka(clk),    // input wire clka
        .ena(scale_valid),      // input wire ena
        .wea(scale_valid),      // input wire [0 : 0] wea
        .addra(scale_data_write_addr_reg),  // input wire [9 : 0] addra
        .dina({m_cmp_result_reg7,scale_data}),    // input wire [16 : 0] dina
        .clkb(clk),    // input wire clkb
        .enb(scale_data_for_r_read_en_wire),      // input wire enb
        .addrb(scale_data_for_r_read_addr_reg),  // input wire [9 : 0] addrb
        .doutb(scale_data_for_r)  // output wire [16 : 0] doutb
    );

    reg[15:0] r_data_need_scale;

    always @(*) 
    begin
        if(scale_data_for_r[16] == 0) r_data_need_scale = old_r_read_data;
        else r_data_need_scale = local_r_reg2;
    end

    reg[15:0] r_reg1;
    reg[15:0] r_reg2;
    reg[15:0] r_reg3;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            r_reg1 <= 0;
            r_reg2 <= 0;
            r_reg3 <= 0;
        end
        else        
        begin
            if(scale_data_for_r[16] == 0) r_reg1 <= local_r_reg2;
            else r_reg1 <= old_r_read_data;
            r_reg2 <= r_reg1;
            r_reg3 <= r_reg2;
        end
    end

    wire r_data_scaled_valid;
    wire[15:0] r_data_scaled;

    fp16_multiply r_scale (
        .aclk                (clk),

        .s_axis_a_tvalid     (local_r_valid_reg2),
        .s_axis_a_tdata      (scale_data_for_r[15:0]),

        .s_axis_b_tvalid     (local_r_valid_reg2),
        .s_axis_b_tdata      (r_data_need_scale),

        .m_axis_result_tvalid(r_data_scaled_valid),
        .m_axis_result_tdata (r_data_scaled)
    );

    wire[15:0] new_r_data;

    fp16_add new_r_add (
        .aclk                (clk),

        .s_axis_a_tvalid     (r_data_scaled_valid),
        .s_axis_a_tdata      (r_data_scaled),

        .s_axis_b_tvalid     (r_data_scaled_valid),
        .s_axis_b_tdata      (r_reg3),

        .m_axis_result_tvalid(new_r_data_valid),
        .m_axis_result_tdata (new_r_data)
    );

    
    reg new_r_write_en_wire;
    reg[15:0] new_r_write_data_wire;

    always @(*) 
    begin
        new_r_write_en_wire = new_r_data_valid;
        if(r_iter_cnt == 0) new_r_write_data_wire = local_r_reg6;
        else new_r_write_data_wire = new_r_data;
    end

    reg[9:0] new_r_write_addr_reg;
    reg[7:0] r_iter_cnt;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            new_r_write_addr_reg <= 0;
            r_iter_cnt <= 0;
        end
        else        
        begin
            if(new_r_data_valid)
            begin
                if(new_r_write_addr_reg < Q_TOKENS - 1)  new_r_write_addr_reg <= new_r_write_addr_reg + 1;
                else if(r_iter_cnt < iter_num_reg - 1)
                begin
                    r_iter_cnt <= r_iter_cnt + 1;
                    new_r_write_addr_reg <= 0;
                end
                else
                begin
                    r_iter_cnt <= 0;
                    new_r_write_addr_reg <= 0;
                end
            end
        end
    end

    reg r_result_write_en_wire;

    always @(*) r_result_write_en_wire = new_r_data_valid && (r_iter_cnt == iter_num_reg - 1);
    
    wire[15:0] r_result_read_data;

    bram_18kb_mem r_result_mem (
        .clka(clk),         // input wire clka
        .ena(r_result_write_en_wire),        // input wire ena
        .wea(r_result_write_en_wire),        // input wire [0 : 0] wea
        .addra(new_r_write_addr_reg),    // input wire [9 : 0] addra
        .dina(new_r_write_data_wire),    // input wire [15 : 0] dina
        .clkb(clk),            // input wire clkb
        .enb(r_result_read_en_wire),      // input wire enb
        .addrb(scale_data_for_o_read_addr_reg7),  // input wire [9 : 0] addrb
        .doutb(r_result_read_data)     // output wire [15 : 0] doutb
    );

//r end

//o begin

    bram_30x36kb_mem o_temp_mem (
        .clka(clk),    // input wire clka
        .ena(new_o_write_en_wire),      // input wire ena
        .wea(new_o_write_en_wire),      // input wire [0 : 0] wea
        .addra(new_o_write_addr_reg),  // input wire [15 : 0] addra
        .dina(new_o_write_data_wire),    // input wire [15 : 0] dina
        .clkb(clk),    // input wire clkb
        .enb(old_o_read_en_wire),      // input wire enb
        .addrb(old_o_read_addr_reg),  // input wire [15 : 0] addrb
        .doutb(old_o_read_data)  // output wire [15 : 0] doutb
    );

    wire[16:0] scale_data_for_o;

    bram_18kb_17bit_mem scale_data_for_o_mem(
        .clka(clk),    // input wire clka
        .ena(scale_valid),      // input wire ena
        .wea(scale_valid),      // input wire [0 : 0] wea
        .addra(scale_data_write_addr_reg),  // input wire [9 : 0] addra
        .dina({m_cmp_result_reg7,scale_data}),    // input wire [16 : 0] dina
        .clkb(clk),    // input wire clkb
        .enb(scale_data_for_o_read_en_wire),      // input wire enb
        .addrb(scale_data_for_o_read_addr_reg),  // input wire [9 : 0] addrb
        .doutb(scale_data_for_o)  // output wire [16 : 0] doutb
    );

    reg[15:0] old_o_read_addr_reg;

    reg[9:0] scale_data_for_o_read_addr_reg;
    reg[9:0] scale_data_for_o_read_addr_reg1;
    reg[9:0] scale_data_for_o_read_addr_reg2;
    reg[9:0] scale_data_for_o_read_addr_reg3;
    reg[9:0] scale_data_for_o_read_addr_reg4;
    reg[9:0] scale_data_for_o_read_addr_reg5;
    reg[9:0] scale_data_for_o_read_addr_reg6;
    reg[9:0] scale_data_for_o_read_addr_reg7;

    reg[6:0] local_o_cnt;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)  
        begin
            old_o_read_addr_reg <= 0;

            scale_data_for_o_read_addr_reg <= 0;
            scale_data_for_o_read_addr_reg1 <= 0;
            scale_data_for_o_read_addr_reg2 <= 0;
            scale_data_for_o_read_addr_reg3 <= 0;
            scale_data_for_o_read_addr_reg4 <= 0;
            scale_data_for_o_read_addr_reg5 <= 0;
            scale_data_for_o_read_addr_reg6 <= 0;
            scale_data_for_o_read_addr_reg7 <= 0;

            local_o_cnt <= 0;
        end
        else        
        begin    
            scale_data_for_o_read_addr_reg1 <= scale_data_for_o_read_addr_reg;
            scale_data_for_o_read_addr_reg2 <= scale_data_for_o_read_addr_reg1;
            scale_data_for_o_read_addr_reg3 <= scale_data_for_o_read_addr_reg2;
            scale_data_for_o_read_addr_reg4 <= scale_data_for_o_read_addr_reg3;
            scale_data_for_o_read_addr_reg5 <= scale_data_for_o_read_addr_reg4;
            scale_data_for_o_read_addr_reg6 <= scale_data_for_o_read_addr_reg5;
            scale_data_for_o_read_addr_reg7 <= scale_data_for_o_read_addr_reg6;

            if(local_o_data_valid_in)
            begin

                if(old_o_read_addr_reg < Q_TOKENS*HEAD_DIM-1) old_o_read_addr_reg <= old_o_read_addr_reg + 1;
                else old_o_read_addr_reg <= 0;

                if(local_o_cnt < HEAD_DIM - 1) 
                begin
                    local_o_cnt <= local_o_cnt + 1;
                    scale_data_for_o_read_addr_reg <= scale_data_for_o_read_addr_reg;
                end
                else if(local_o_cnt == HEAD_DIM - 1)
                begin
                    local_o_cnt <= local_o_cnt + 1;
                    if(scale_data_for_o_read_addr_reg < Q_TOKENS - 1) scale_data_for_o_read_addr_reg <= scale_data_for_o_read_addr_reg + 1;
                    else scale_data_for_o_read_addr_reg <= 0;
                end
                else
                begin
                    local_o_cnt <= 1;
                    scale_data_for_o_read_addr_reg <= scale_data_for_o_read_addr_reg;
                end
            end
        end
    end

    reg old_o_read_en_wire;
    reg scale_data_for_o_read_en;

    reg scale_data_for_o_read_en_reg1;
    reg scale_data_for_o_read_en_reg2;
    reg scale_data_for_o_read_en_reg3;
    reg scale_data_for_o_read_en_reg4;
    reg scale_data_for_o_read_en_reg5;
    reg scale_data_for_o_read_en_reg6;
    reg scale_data_for_o_read_en_reg7;

    reg local_o_valid_reg1;
    reg local_o_valid_reg2;
    reg local_o_valid_reg3;

    reg scale_data_for_o_read_en_wire;

    always @(*) 
    begin
        old_o_read_en_wire = local_o_data_valid_in || local_o_valid_reg1;
        scale_data_for_o_read_en = (local_o_cnt == 0 || local_o_cnt == HEAD_DIM) && (local_o_data_valid_in);
        scale_data_for_o_read_en_wire = scale_data_for_o_read_en || scale_data_for_o_read_en_reg1;
    end

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n) 
        begin
            scale_data_for_o_read_en_reg1 <= 0;
            scale_data_for_o_read_en_reg2 <= 0;
            scale_data_for_o_read_en_reg3 <= 0;
            scale_data_for_o_read_en_reg4 <= 0;
            scale_data_for_o_read_en_reg5 <= 0;
            scale_data_for_o_read_en_reg6 <= 0;
            scale_data_for_o_read_en_reg7 <= 0;

            local_o_valid_reg1 <= 0;
            local_o_valid_reg2 <= 0;
            local_o_valid_reg3 <= 0;
        end
        else 
        begin
            scale_data_for_o_read_en_reg1 <= scale_data_for_o_read_en; 
            scale_data_for_o_read_en_reg2 <= scale_data_for_o_read_en_reg1;
            scale_data_for_o_read_en_reg3 <= scale_data_for_o_read_en_reg2;
            scale_data_for_o_read_en_reg4 <= scale_data_for_o_read_en_reg3;
            scale_data_for_o_read_en_reg5 <= scale_data_for_o_read_en_reg4;
            scale_data_for_o_read_en_reg6 <= scale_data_for_o_read_en_reg5;
            scale_data_for_o_read_en_reg7 <= scale_data_for_o_read_en_reg6;

            local_o_valid_reg1 <= local_o_data_valid_in;
            local_o_valid_reg2 <= local_o_valid_reg1;
            local_o_valid_reg3 <= local_o_valid_reg2;
        end
    end

    reg[15:0] old_o_data_reg;
    reg[16:0] scale_data_for_o_reg;
    wire[15:0] old_o_read_data;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n) 
        begin
            old_o_data_reg <= 0;
            scale_data_for_o_reg <= 0;
        end
        else 
        begin
            if(scale_data_for_o_read_en_reg2) scale_data_for_o_reg <= scale_data_for_o;
            else scale_data_for_o_reg <= scale_data_for_o_reg;

            if(local_o_valid_reg2) old_o_data_reg <= old_o_read_data;
            else old_o_data_reg <= old_o_data_reg;
        end
    end

    reg[15:0] local_o_reg1;
    reg[15:0] local_o_reg2;
    reg[15:0] local_o_reg3;
    reg[15:0] local_o_reg4;
    reg[15:0] local_o_reg5;
    reg[15:0] local_o_reg6;
    reg[15:0] local_o_reg7;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            local_o_reg1 <= 0;
            local_o_reg2 <= 0;
            local_o_reg3 <= 0;
            local_o_reg4 <= 0;
            local_o_reg5 <= 0;
            local_o_reg6 <= 0;
            local_o_reg7 <= 0;
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
        end
    end

    reg[15:0] o_data_need_scale;

    always @(*)    
    begin
        if(scale_data_for_o_reg[16] == 0) o_data_need_scale = old_o_data_reg;
        else o_data_need_scale = local_o_reg3;
    end

    wire o_data_scaled_valid;
    wire[15:0] o_data_scaled;

    fp16_multiply o_scale (
        .aclk                (clk),

        .s_axis_a_tvalid     (local_o_valid_reg3),
        .s_axis_a_tdata      (scale_data_for_o_reg[15:0]),

        .s_axis_b_tvalid     (local_o_valid_reg3),
        .s_axis_b_tdata      (o_data_need_scale),

        .m_axis_result_tvalid(o_data_scaled_valid),
        .m_axis_result_tdata (o_data_scaled)
    );

    reg[15:0] o_reg1;
    reg[15:0] o_reg2;
    reg[15:0] o_reg3;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            o_reg1 <= 0;
            o_reg2 <= 0;
            o_reg3 <= 0;
        end
        else        
        begin            
            if(scale_data_for_o_reg[16] == 0) o_reg1 <= local_o_reg3;
            else o_reg1 <= old_o_data_reg;
            o_reg2 <= o_reg1;
            o_reg3 <= o_reg2;
        end
    end

    wire new_o_data_valid;
    wire[15:0] new_o_data;

    fp16_add new_o_add (
        .aclk                (clk),

        .s_axis_a_tvalid     (o_data_scaled_valid),
        .s_axis_a_tdata      (o_data_scaled),

        .s_axis_b_tvalid     (o_data_scaled_valid),
        .s_axis_b_tdata      (o_reg3),

        .m_axis_result_tvalid(new_o_data_valid),
        .m_axis_result_tdata (new_o_data)
    );

    reg[7:0] o_iter_cnt;
    reg[15:0] new_o_write_addr_reg;
    reg single_iter_done_reg;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            o_iter_cnt <= 0;
            new_o_write_addr_reg <= 0;
            single_iter_done_reg <= 0;
        end
        else        
        begin            
            if(new_o_data_valid)
            begin
                if(new_o_write_addr_reg < Q_TOKENS*HEAD_DIM - 1) 
                begin
                    new_o_write_addr_reg <= new_o_write_addr_reg + 1;
                    o_iter_cnt <= o_iter_cnt;
                    single_iter_done_reg <= 0;
                end
                else if(o_iter_cnt < iter_num_reg - 1)
                begin
                    o_iter_cnt <= o_iter_cnt + 1;
                    new_o_write_addr_reg <= 0;
                    single_iter_done_reg <= 1;
                end
                else                
                begin
                    o_iter_cnt <= 0;
                    new_o_write_addr_reg <= 0;
                    single_iter_done_reg <= 1;
                end
            end
            else            
            begin
                o_iter_cnt <= o_iter_cnt;
                new_o_write_addr_reg <= new_o_write_addr_reg;
                single_iter_done_reg <= 0;
            end
        end
    end

    reg new_o_write_en_wire;
    reg[15:0] new_o_write_data_wire;

    always @(*)    
    begin
        new_o_write_en_wire = new_o_data_valid;
        if(o_iter_cnt == 0) new_o_write_data_wire = local_o_reg7;
        else new_o_write_data_wire = new_o_data;
    end

    reg r_result_read_en_wire;
    reg r_result_read_en;

    reg r_result_read_en_reg1;
    reg r_result_read_en_reg2;

    always @(*)    
    begin
        r_result_read_en = (o_iter_cnt == iter_num_reg - 1) && scale_data_for_o_read_en_reg7;
        r_result_read_en_wire = r_result_read_en || r_result_read_en_reg1;
    end


    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            r_result_read_en_reg1 <= 0;
            r_result_read_en_reg2 <= 0;
        end
        else        
        begin
            r_result_read_en_reg1 <= r_result_read_en;
            r_result_read_en_reg2 <= r_result_read_en_reg1;
        end
    end

    reg last_iter_o_valid_reg1;
    reg last_iter_o_valid_reg2;
    reg last_iter_o_valid_reg3;

    reg[15:0] last_iter_o_reg1;
    reg[15:0] last_iter_o_reg2;
    reg[15:0] last_iter_o_reg3;

    reg[9:0] r_result_read_addr_reg;
    reg[15:0] r_result_data_reg;
                                        
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            last_iter_o_valid_reg1 <= 0;
            last_iter_o_valid_reg2 <= 0;
            last_iter_o_valid_reg3 <= 0;

            last_iter_o_reg1 <= 0;
            last_iter_o_reg2 <= 0;
            last_iter_o_reg3 <= 0;

            r_result_read_addr_reg <= 0;
            r_result_data_reg <= 0;
        end
        else
        begin      
            last_iter_o_valid_reg1 <= new_o_data_valid && (o_iter_cnt == iter_num_reg - 1);
            last_iter_o_valid_reg2 <= last_iter_o_valid_reg1;
            last_iter_o_valid_reg3 <= last_iter_o_valid_reg2;

            last_iter_o_reg1 <= new_o_write_data_wire;
            last_iter_o_reg2 <= last_iter_o_reg1;
            last_iter_o_reg3 <= last_iter_o_reg2;

            if(new_o_data_valid && (o_iter_cnt == iter_num_reg - 1)) r_result_read_addr_reg <= scale_data_for_o_read_addr_reg6;
            else r_result_read_addr_reg <= r_result_read_addr_reg;

            if(r_result_read_en_reg2) r_result_data_reg <= r_result_read_data;
            else r_result_data_reg <= r_result_data_reg;
        end
    end

    wire[15:0] o_normalized_data;
    wire o_normalized_valid;

    fp16_div o_normalization (
    .aclk(clk),                                  // input wire aclk
    .s_axis_a_tvalid(last_iter_o_valid_reg3),            // input wire s_axis_a_tvalid
    .s_axis_a_tdata(last_iter_o_reg3),              // input wire [15 : 0] s_axis_a_tdata
    .s_axis_b_tvalid(last_iter_o_valid_reg3),            // input wire s_axis_b_tvalid
    .s_axis_b_tdata(r_result_data_reg),              // input wire [15 : 0] s_axis_b_tdata
    .m_axis_result_tvalid(o_normalized_valid),  // output wire m_axis_result_tvalid
    .m_axis_result_tdata(o_normalized_data)    // output wire [15 : 0] m_axis_result_tdata
    );

    bram_30x36kb_mem o_result_mem (
        .clka(clk),    // input wire clka
        .ena(o_result_write_en_wire),      // input wire ena
        .wea(o_result_write_en_wire),      // input wire [0 : 0] wea
        .addra(o_result_write_addr_reg),  // input wire [15 : 0] addra
        .dina(o_normalized_data),    // input wire [15 : 0] dina
        .clkb(bram_to_axi_clk),    // input wire clkb
        .enb(o_result_read_en_wire),      // input wire enb
        .addrb(o_result_read_addr_in),  // input wire [15 : 0] addrb
        .doutb(o_result_read_data_out)  // output wire [15 : 0] doutb
    );

    reg o_result_write_en_wire;

    always @(*) o_result_write_en_wire = o_normalized_valid;

    reg[15:0] o_result_write_addr_reg;
    reg all_iter_done_reg;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            o_result_write_addr_reg <= 0;
            all_iter_done_reg <= 0;
        end
        else        
        begin
            if(o_normalized_valid)
            begin
                if(o_result_write_addr_reg < Q_TOKENS*HEAD_DIM - 1) 
                begin
                    o_result_write_addr_reg <= o_result_write_addr_reg + 1;
                    all_iter_done_reg <= 0;
                end
                else 
                begin
                    o_result_write_addr_reg <= 0;
                    all_iter_done_reg <= 1;
                end
            end
            else 
            begin
                o_result_write_addr_reg <= o_result_write_addr_reg;
                all_iter_done_reg <= 0;
            end
        end
    end

    reg o_result_read_en_wire;
    reg o_result_read_en_reg1;
    reg o_result_read_en_reg2;

    always @(*) o_result_read_en_wire = o_result_read_en_in || o_result_read_en_reg1;

    always @(posedge bram_to_axi_clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            o_result_read_en_reg1 <= 0;
            o_result_read_en_reg2 <= 0;
        end
        else        
        begin
            o_result_read_en_reg1 <= o_result_read_en_in;
            o_result_read_en_reg2 <= o_result_read_en_reg1;
        end
    end

    assign o_result_read_valid_out = o_result_read_en_reg2;
    assign single_iter_done_out = single_iter_done_reg;
    assign all_iter_done_out = all_iter_done_reg;

//o end
endmodule
    