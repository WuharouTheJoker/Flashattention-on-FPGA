vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/hdl/axi_flashattention2_unit_ctrl_v1_0_S00_AXI.v" \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/hdl/axi_flashattention2_unit_ctrl_v1_0.v" \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/sim/axi_flashattention2_unit_ctrl_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

