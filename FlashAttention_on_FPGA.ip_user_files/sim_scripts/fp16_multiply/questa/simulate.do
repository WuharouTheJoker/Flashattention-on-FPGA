onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib fp16_multiply_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {fp16_multiply.udo}

run 1000ns

quit -force
