transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+axi_intc_0  -L xilinx_vip -L xpm -L axi_lite_ipif_v3_0_4 -L axi_intc_v4_1_18 -L xil_defaultlib -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axi_intc_0 xil_defaultlib.glbl

do {axi_intc_0.udo}

run 1000ns

endsim

quit -force
