vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xbip_utils_v3_0_11
vlib questa_lib/msim/c_reg_fd_v12_0_7
vlib questa_lib/msim/c_mux_bit_v12_0_7
vlib questa_lib/msim/c_shift_ram_v12_0_15
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xbip_utils_v3_0_11 questa_lib/msim/xbip_utils_v3_0_11
vmap c_reg_fd_v12_0_7 questa_lib/msim/c_reg_fd_v12_0_7
vmap c_mux_bit_v12_0_7 questa_lib/msim/c_mux_bit_v12_0_7
vmap c_shift_ram_v12_0_15 questa_lib/msim/c_shift_ram_v12_0_15
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_11  -93  \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work c_reg_fd_v12_0_7  -93  \
"../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \

vcom -work c_mux_bit_v12_0_7  -93  \
"../../../ipstatic/hdl/c_mux_bit_v12_0_vh_rfs.vhd" \

vcom -work c_shift_ram_v12_0_15  -93  \
"../../../ipstatic/hdl/c_shift_ram_v12_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../../FlashAttention_on_FPGA.gen/sources_1/ip/s_buffer/sim/s_buffer.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

