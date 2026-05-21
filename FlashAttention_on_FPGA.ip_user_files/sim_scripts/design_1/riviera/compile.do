transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_15
vlib riviera/zynq_ultra_ps_e_vip_v1_0_15
vlib riviera/xil_defaultlib
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_14
vlib riviera/lib_pkg_v1_0_3
vlib riviera/lib_srl_fifo_v1_0_3
vlib riviera/fifo_generator_v13_2_9
vlib riviera/lib_fifo_v1_0_18
vlib riviera/axi_datamover_v5_1_31
vlib riviera/axi_sg_v4_1_17
vlib riviera/axi_cdma_v4_1_29
vlib riviera/xlconstant_v1_1_8
vlib riviera/smartconnect_v1_0
vlib riviera/axi_register_slice_v2_1_29
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/interrupt_control_v3_1_5
vlib riviera/axi_gpio_v2_0_31

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_15 riviera/axi_vip_v1_1_15
vmap zynq_ultra_ps_e_vip_v1_0_15 riviera/zynq_ultra_ps_e_vip_v1_0_15
vmap xil_defaultlib riviera/xil_defaultlib
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_14 riviera/proc_sys_reset_v5_0_14
vmap lib_pkg_v1_0_3 riviera/lib_pkg_v1_0_3
vmap lib_srl_fifo_v1_0_3 riviera/lib_srl_fifo_v1_0_3
vmap fifo_generator_v13_2_9 riviera/fifo_generator_v13_2_9
vmap lib_fifo_v1_0_18 riviera/lib_fifo_v1_0_18
vmap axi_datamover_v5_1_31 riviera/axi_datamover_v5_1_31
vmap axi_sg_v4_1_17 riviera/axi_sg_v4_1_17
vmap axi_cdma_v4_1_29 riviera/axi_cdma_v4_1_29
vmap xlconstant_v1_1_8 riviera/xlconstant_v1_1_8
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap axi_register_slice_v2_1_29 riviera/axi_register_slice_v2_1_29
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap interrupt_control_v3_1_5 riviera/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_31 riviera/axi_gpio_v2_0_31

vlog -work xilinx_vip  -incr "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"F:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"F:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_15  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/5753/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_15  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_zynq_ultra_ps_e_0_0/sim/design_1_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work lib_cdc_v1_0_2 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_14 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/408c/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_rst_ps8_0_149M_0/sim/design_1_rst_ps8_0_149M_0.vhd" \

vcom -work lib_pkg_v1_0_3 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/56d9/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_3 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/02c4/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_9  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ac72/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_9 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ac72/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_9  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ac72/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_18 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/1531/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_31 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/d786/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_17 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/1b4d/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_cdma_v4_1_29 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/0f35/hdl/axi_cdma_v4_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_axi_cdma_0_0/sim/design_1_axi_cdma_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_head_dim_4_top_module_0_2/sim/design_1_head_dim_4_top_module_0_2.v" \

vlog -work xlconstant_v1_1_8  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/d390/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_0/sim/bd_48ac_one_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_1/sim/bd_48ac_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/bd53/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_2/sim/bd_48ac_arsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_3/sim/bd_48ac_rsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_4/sim/bd_48ac_awsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_5/sim/bd_48ac_wsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_6/sim/bd_48ac_bsw_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/c6b2/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_7/sim/bd_48ac_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/abb8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_8/sim/bd_48ac_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/7827/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_9/sim/bd_48ac_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/79ce/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_10/sim/bd_48ac_s00a2s_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_11/sim/bd_48ac_sarn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_12/sim/bd_48ac_srn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_13/sim/bd_48ac_sawn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_14/sim/bd_48ac_swn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_15/sim/bd_48ac_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ebf7/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_16/sim/bd_48ac_m00s2a_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_17/sim/bd_48ac_m00arn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_18/sim/bd_48ac_m00rn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_19/sim/bd_48ac_m00awn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_20/sim/bd_48ac_m00wn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_21/sim/bd_48ac_m00bn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/6eea/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_22/sim/bd_48ac_m00e_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_23/sim/bd_48ac_m01s2a_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_24/sim/bd_48ac_m01arn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_25/sim/bd_48ac_m01rn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_26/sim/bd_48ac_m01awn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_27/sim/bd_48ac_m01wn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_28/sim/bd_48ac_m01bn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_29/sim/bd_48ac_m01e_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_30/sim/bd_48ac_m02s2a_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_31/sim/bd_48ac_m02arn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_32/sim/bd_48ac_m02rn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_33/sim/bd_48ac_m02awn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_34/sim/bd_48ac_m02wn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_35/sim/bd_48ac_m02bn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/ip/ip_36/sim/bd_48ac_m02e_0.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/bd_0/sim/bd_48ac.v" \

vlog -work axi_register_slice_v2_1_29  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ff9f/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_0_0/sim/design_1_smartconnect_0_0.v" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_0/sim/bd_88fd_one_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_1/sim/bd_88fd_psr_aclk_0.vhd" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_2/sim/bd_88fd_arinsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_3/sim/bd_88fd_rinsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_4/sim/bd_88fd_awinsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_5/sim/bd_88fd_winsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_6/sim/bd_88fd_binsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_7/sim/bd_88fd_aroutsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_8/sim/bd_88fd_routsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_9/sim/bd_88fd_awoutsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_10/sim/bd_88fd_woutsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_11/sim/bd_88fd_boutsw_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_12/sim/bd_88fd_arni_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_13/sim/bd_88fd_rni_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_14/sim/bd_88fd_awni_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_15/sim/bd_88fd_wni_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_16/sim/bd_88fd_bni_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_17/sim/bd_88fd_s00mmu_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_18/sim/bd_88fd_s00tr_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_19/sim/bd_88fd_s00sic_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_20/sim/bd_88fd_s00a2s_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_21/sim/bd_88fd_sarn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_22/sim/bd_88fd_srn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_23/sim/bd_88fd_sawn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_24/sim/bd_88fd_swn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_25/sim/bd_88fd_sbn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_26/sim/bd_88fd_m00s2a_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_27/sim/bd_88fd_m00arn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_28/sim/bd_88fd_m00rn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_29/sim/bd_88fd_m00awn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_30/sim/bd_88fd_m00wn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_31/sim/bd_88fd_m00bn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_32/sim/bd_88fd_m00e_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_33/sim/bd_88fd_m01s2a_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_34/sim/bd_88fd_m01arn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_35/sim/bd_88fd_m01rn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_36/sim/bd_88fd_m01awn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_37/sim/bd_88fd_m01wn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_38/sim/bd_88fd_m01bn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_39/sim/bd_88fd_m01e_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_40/sim/bd_88fd_m02s2a_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_41/sim/bd_88fd_m02arn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_42/sim/bd_88fd_m02rn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_43/sim/bd_88fd_m02awn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_44/sim/bd_88fd_m02wn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_45/sim/bd_88fd_m02bn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_46/sim/bd_88fd_m02e_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_47/sim/bd_88fd_m03s2a_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_48/sim/bd_88fd_m03arn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_49/sim/bd_88fd_m03rn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_50/sim/bd_88fd_m03awn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_51/sim/bd_88fd_m03wn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_52/sim/bd_88fd_m03bn_0.sv" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_53/sim/bd_88fd_m03e_0.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/bd_0/sim/bd_88fd.v" \
"../../../bd/design_1/ip/design_1_smartconnect_1_0/sim/design_1_smartconnect_1_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work interrupt_control_v3_1_5 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_31 -93  -incr \
"../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/6fbe/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_axi_gpio_0_0/sim/design_1_axi_gpio_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/2fcd/hdl" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../FlashAttention_on_FPGA.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog" "+incdir+F:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l zynq_ultra_ps_e_vip_v1_0_15 -l xil_defaultlib -l lib_cdc_v1_0_2 -l proc_sys_reset_v5_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l fifo_generator_v13_2_9 -l lib_fifo_v1_0_18 -l axi_datamover_v5_1_31 -l axi_sg_v4_1_17 -l axi_cdma_v4_1_29 -l xlconstant_v1_1_8 -l smartconnect_v1_0 -l axi_register_slice_v2_1_29 -l axi_lite_ipif_v3_0_4 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

