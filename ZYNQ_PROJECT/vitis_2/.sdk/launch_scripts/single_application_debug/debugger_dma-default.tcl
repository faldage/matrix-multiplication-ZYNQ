connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/platform/export/platform/hw/top_design.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
stop
source C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/dma/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
rst -processor
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/dma/Debug/dma.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
