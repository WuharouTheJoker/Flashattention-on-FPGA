transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xilinx_vip
vlib activehdl/xpm
vlib activehdl/lib_pkg_v1_0_3
vlib activehdl/lib_srl_fifo_v1_0_3
vlib activehdl/fifo_generator_v13_2_9
vlib activehdl/lib_fifo_v1_0_18
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/axi_datamover_v5_1_31
vlib activehdl/axi_sg_v4_1_17
vlib activehdl/axi_cdma_v4_1_29
vlib activehdl/xil_defaultlib

vmap xilinx_vip activehdl/xilinx_vip
vmap xpm activehdl/xpm
vmap lib_pkg_v1_0_3 activehdl/lib_pkg_v1_0_3
vmap lib_srl_fifo_v1_0_3 activehdl/lib_srl_fifo_v1_0_3
vmap fifo_generator_v13_2_9 activehdl/fifo_generator_v13_2_9
vmap lib_fifo_v1_0_18 activehdl/lib_fifo_v1_0_18
vmap lib_cdc_v1_0_2 activehdl/lib_cdc_v1_0_2
vmap axi_datamover_v5_1_31 activehdl/axi_datamover_v5_1_31
vmap axi_sg_v4_1_17 activehdl/axi_sg_v4_1_17
vmap axi_cdma_v4_1_29 activehdl/axi_cdma_v4_1_29
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xilinx_vip  -sv2k12 "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l lib_cdc_v1_0_2 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xil_defaultlib \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l lib_cdc_v1_0_2 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xil_defaultlib \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work lib_pkg_v1_0_3 -93  \
"../../../ipstatic/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_3 -93  \
"../../../ipstatic/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_9  -v2k5 "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l lib_cdc_v1_0_2 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xil_defaultlib \
"../../../ipstatic/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_9 -93  \
"../../../ipstatic/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_9  -v2k5 "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l lib_cdc_v1_0_2 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xil_defaultlib \
"../../../ipstatic/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_18 -93  \
"../../../ipstatic/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93  \
"../../../ipstatic/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_31 -93  \
"../../../ipstatic/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_17 -93  \
"../../../ipstatic/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_cdma_v4_1_29 -93  \
"../../../ipstatic/hdl/axi_cdma_v4_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../../ip_repo/axi_cdma_0/sim/axi_cdma_0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

