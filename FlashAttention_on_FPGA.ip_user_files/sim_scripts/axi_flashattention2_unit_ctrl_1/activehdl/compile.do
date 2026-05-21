transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 -l xpm -l xil_defaultlib \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 -l xpm -l xil_defaultlib \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/hdl/axi_flashattention2_unit_ctrl_v1_0_S00_AXI.v" \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/hdl/axi_flashattention2_unit_ctrl_v1_0.v" \
"../../../../../ip_repo/axi_flashattention2_unit_ctrl_1/sim/axi_flashattention2_unit_ctrl_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

