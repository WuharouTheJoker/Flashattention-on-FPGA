`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/16 19:19:56
// Design Name: 
// Module Name: tb_ws_pe_array
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


module tb_ws_pe_array;

parameter TOKENS   = 8;
parameter HEAD_DIM = 4;

// Q矩阵
reg [15:0] Q_mem [0:TOKENS*HEAD_DIM-1];

// K矩阵
reg [15:0] K_mem [0:TOKENS*HEAD_DIM-1];

// Golden结果
reg [15:0] S_golden [0:TOKENS*TOKENS-1];


initial 
begin

    $display("Loading memory files...");

    $readmemh("Q.mem", Q_mem);
    $readmemh("K.mem", K_mem);

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

initial 
begin
    clk = 1;
    forever #5 clk = ~clk;   // 100MHz
end

ws_pe_array dut(
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

integer fout;

initial begin
    fout = $fopen("S_output.mem","w");

    if(fout == 0)
        $display("ERROR: cannot open output file");
end

always @(posedge clk)
begin
    if(s_out_valid)
    begin
        $fdisplay(fout,"%h", s_out);
    end
end

integer cycles;
integer ws_pe_id;

initial 
begin

    rst_n = 0;
    q_in_bus = 0;
    k_in_bus = 0;
    q_in_valid_bus = 0;
    k_in_valid_bus = 0;

    #100
    @(posedge clk);
    rst_n <= 1;
    for (cycles = 0; cycles < TOKENS*TOKENS+HEAD_DIM-1; cycles = cycles + 1)
    begin
        if(cycles < TOKENS*TOKENS+HEAD_DIM-1)
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

            @(posedge clk);
        end
    end

    #100
    $fclose(fout);
end


endmodule
