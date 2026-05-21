transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+axi_cdma_0  -L xilinx_vip -L xpm -L lib_pkg_v1_0_3 -L lib_srl_fifo_v1_0_3 -L fifo_generator_v13_2_9 -L lib_fifo_v1_0_18 -L lib_cdc_v1_0_2 -L axi_datamover_v5_1_31 -L axi_sg_v4_1_17 -L axi_cdma_v4_1_29 -L xil_defaultlib -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axi_cdma_0 xil_defaultlib.glbl

do {axi_cdma_0.udo}

run 1000ns

endsim

quit -force
