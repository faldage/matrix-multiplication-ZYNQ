connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-HS1 210512180081" && level==0 && jtag_device_ctx=="jsn-JTAG-HS1-210512180081-23727093-0"}
fpga -file C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/dma/_ide/bitstream/top_design.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/platform/export/platform/hw/top_design.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/dma/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/dma/Debug/dma.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
