`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/19 00:36:14
// Design Name: 
// Module Name: tb_flashattention_unit
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


module tb_flashattention_unit;

    parameter TOKENS   = 8;
    parameter HEAD_DIM = 4;
    parameter PE_ARRY_INPUT_TIME = TOKENS*TOKENS + HEAD_DIM - 1;
    parameter MAC_LATENCY = 4;
    parameter PE_ARRAY_LATENCY = HEAD_DIM - 1;
    parameter SCALE_LATENCY = 3;
    parameter FIRST_S_LATENCY = MAC_LATENCY + PE_ARRAY_LATENCY + SCALE_LATENCY;
    parameter CMP_LATENCY = 1;
    parameter SHIFT_REG_LATENCY = TOKENS;
    parameter EXP_LATENCY = 8;
    parameter SOFTMAX_LATENCY = CMP_LATENCY + SHIFT_REG_LATENCY + EXP_LATENCY;
    parameter FIRST_P_LATENCY = FIRST_S_LATENCY + SOFTMAX_LATENCY;
    parameter inv_sqrt_head_dim = 16'h2da8; // 1/sqrt(128) ≈ 0.088388, fp16 = 16'h2da8

    // Q矩阵
    reg [15:0] Q_mem [0:TOKENS*HEAD_DIM-1];

    // K矩阵
    reg [15:0] K_mem [0:TOKENS*HEAD_DIM-1];

    // V矩阵
    reg [15:0] V_mem [0:TOKENS*HEAD_DIM-1];



    initial 
    begin

        $display("Loading memory files...");

        $readmemh("Q.mem", Q_mem);
        $readmemh("K.mem", K_mem);
        $readmemh("V.mem", V_mem);

        $display("Memory loaded.");

    end

    reg clk;
    reg rst_n;

    reg [HEAD_DIM*16-1:0] q_in_bus;
    reg [HEAD_DIM-1:0]  q_in_valid_bus;

    reg [HEAD_DIM*16-1:0] k_in_bus;
    reg [HEAD_DIM-1:0]  k_in_valid_bus;

    wire [15:0] s_out;
    wire s_out_valid;
    wire s_last_out;

    ws_pe_array #(
        .HEAD_DIM(HEAD_DIM),
        // .inv_sqrt_head_dim(inv_sqrt_head_dim),
        .TOKENS(TOKENS)
        
    )ws_pe_array_dut(
        .clk(clk),
        .rst_n(rst_n),

        .q_in_bus(q_in_bus),
        .q_in_valid_bus(q_in_valid_bus),

        .k_in_bus(k_in_bus),
        .k_in_valid_bus(k_in_valid_bus),

        .s_out(s_out),
        .s_out_valid(s_out_valid),
        .s_last_out(s_last_out)
    );

    wire p_valid_out;
    wire [15:0] p_out;
    wire p_last_out;

    wire r_valid_out;
    wire [15:0] r_out;
    
    wire m_valid_out;
    wire [15:0] m_out;

    safe_softmax_unit uut (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid_in(s_out_valid),
        .s_in(s_out),
        .s_last_in(s_last_out),

        .p_valid_out(p_valid_out),
        .p_last_out(p_last_out),
        .p_out(p_out),

        .r_valid_out(r_valid_out),
        .r_out(r_out),

        .m_valid_out(m_valid_out),
        .m_out(m_out)
    );
    
    reg  [HEAD_DIM*16-1:0] v_in_bus;
    reg  [HEAD_DIM-1:0]    v_in_valid_bus;

    // wire [HEAD_DIM*16-1:0] o_out_bus;
    // wire [HEAD_DIM-1:0]    o_out_valid_bus;

    wire [15:0] o_result_out;
    wire        o_result_out_valid;

    os_pe_array #(
        .HEAD_DIM(HEAD_DIM)
    )os_pe_array_dut(
        .clk(clk),
        .rst_n(rst_n),

        .p_in(p_out),
        .p_in_valid(p_valid_out),
        .p_last_in(p_last_out),

        .v_in_bus(v_in_bus),
        .v_in_valid_bus(v_in_valid_bus),

        // .o_out_bus(o_out_bus),
        // .o_out_valid_bus(o_out_valid_bus),

        .o_result_out(o_result_out),
        .o_result_out_valid(o_result_out_valid)
    );
    
    initial 
    begin
        clk = 1;
        forever #1 clk = ~clk;   // 100MHz
    end

    integer s_fout;
    integer m_fout;
    integer r_fout;
    integer p_fout;
    integer o_fout;

    initial begin
        s_fout = $fopen("S_output.mem","w");
        m_fout = $fopen("m_output.mem","w");
        r_fout = $fopen("R_output.mem","w");
        p_fout = $fopen("P_output.mem","w");
        o_fout = $fopen("O_output.mem","w");
    end

    always @(posedge clk)
    begin
        if(s_out_valid)
        begin
            $fdisplay(s_fout,"%h", s_out);
        end
        if(p_valid_out)
        begin
            $fdisplay(p_fout,"%h", p_out);
        end
        if(r_valid_out)
        begin
            $fdisplay(r_fout,"%h", r_out);
        end
        if(m_valid_out)
        begin
            $fdisplay(m_fout,"%h", m_out);
        end
        if (o_result_out_valid) 
        begin
            $fdisplay(o_fout, "%h", o_result_out);
        end
    end

    integer cycles;
    integer ws_pe_id;
    integer os_pe_id;

    initial 
    begin

        rst_n = 0;
        q_in_bus = 0;
        k_in_bus = 0;
        q_in_valid_bus = 0;
        k_in_valid_bus = 0;

        #20
        @(posedge clk);
        rst_n <= 1;
        for (cycles = 0; cycles < PE_ARRY_INPUT_TIME + FIRST_P_LATENCY; cycles = cycles + 1)
        begin
            if(cycles < PE_ARRY_INPUT_TIME)
            begin
                for(ws_pe_id = 0;ws_pe_id <HEAD_DIM;ws_pe_id = ws_pe_id +1 )
                begin
                    if(cycles-ws_pe_id >= 0 && cycles-ws_pe_id < TOKENS*TOKENS)
                    begin
                        k_in_bus[ws_pe_id*16 +: 16] <= K_mem[(ws_pe_id) + ((cycles-ws_pe_id)%TOKENS)*HEAD_DIM];
                        k_in_valid_bus[ws_pe_id] <= 1;
                    end
                    else
                    begin
                        k_in_bus[ws_pe_id*16 +: 16] <= 0;
                        k_in_valid_bus[ws_pe_id] <= 0;
                    end

                    if((cycles-ws_pe_id >= 0 && cycles-ws_pe_id < TOKENS*TOKENS) && ((cycles-ws_pe_id)%TOKENS == 0))
                    begin
                        q_in_bus[ws_pe_id*16 +: 16] <= Q_mem[((cycles-ws_pe_id)/TOKENS)*HEAD_DIM + ws_pe_id];
                        q_in_valid_bus[ws_pe_id] <= 1;
                    end
                    else
                    begin
                        q_in_bus[ws_pe_id*16 +: 16] <= 0;
                        q_in_valid_bus[ws_pe_id] <= 0;
                    end
                end
            end

            if(cycles >= FIRST_P_LATENCY)
            begin
                for(os_pe_id = 0; os_pe_id < HEAD_DIM; os_pe_id = os_pe_id + 1)
                begin
                    if(((cycles-FIRST_P_LATENCY  -os_pe_id) >= 0) && ((cycles-FIRST_P_LATENCY-os_pe_id) < TOKENS*TOKENS))
                    begin                        
                        v_in_bus[os_pe_id*16 +: 16] <= V_mem[(os_pe_id) + ((cycles-FIRST_P_LATENCY-os_pe_id)%TOKENS)*HEAD_DIM];
                        v_in_valid_bus[os_pe_id] <= 1;
                    end
                    else                    
                    begin
                        v_in_bus[os_pe_id*16 +: 16] <= 0;
                        v_in_valid_bus[os_pe_id] <= 0;  
            
                    end
                end
            end
            @(posedge clk);
        end

        #100
        $fflush(s_fout);
        $fflush(m_fout);
        $fflush(r_fout);
        $fflush(p_fout);
        $finish;
    end
endmodule
