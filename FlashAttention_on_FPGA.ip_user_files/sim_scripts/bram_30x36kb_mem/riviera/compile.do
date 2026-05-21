transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/blk_mem_gen_v8_4_7
vlib riviera/xil_defaultlib

vmap blk_mem_gen_v8_4_7 riviera/blk_mem_gen_v8_4_7
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work blk_mem_gen_v8_4_7  -incr -v2k5 -l blk_mem_gen_v8_4_7 -l xil_defaultlib \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l blk_mem_gen_v8_4_7 -l xil_defaultlib \
"../../../../FlashAttention_on_FPGA.gen/sources_1/ip/bram_30x36kb_mem/sim/bram_30x36kb_mem.v" \


vlog -work xil_defaultlib \
"glbl.v"

