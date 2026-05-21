transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr -l xpm -l xil_defaultlib \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 -l xpm -l xil_defaultlib \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/hdl/axi_flashattention2_unit_ctrl_v1_0_S00_AXI.v" \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/hdl/axi_flashattention2_unit_ctrl_v1_0.v" \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/sim/axi_flashattention2_unit_ctrl_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

