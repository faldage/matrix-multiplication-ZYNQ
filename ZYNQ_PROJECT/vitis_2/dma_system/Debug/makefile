#
# This file was created by Xilinx Vitis tool.
#


#
# tools
#

RM = rm -f
RMDIR = rm -rf



#
# variables
#

SDCARD_GEN = sdcard_gen
GENERATE_BIF = ::scw::generate_bif

XPFM_PATH = C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/platform/export/platform/platform.xpfm
SYS_CONFIG = platform
DOMAINS = standalone_domain
BIF_PATH = C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/dma_system/Debug/system.bif

BITSTREAM_PATH = C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/dma/_ide/bitstream/top_design.bit
SD_FILES = --elf C:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/dma/Debug/dma.elf,ps7_cortexa9_0

#
# primary build targets
#

all: package

package:
	-@echo Generating bif file for the system project
	generate_system_bif.bat 53721 ${XPFM_PATH} ${DOMAINS} ${BIF_PATH}
	${SDCARD_GEN} --xpfm ${XPFM_PATH} --sys_config ${SYS_CONFIG} --bif ${BIF_PATH} --bitstream ${BITSTREAM_PATH} ${SD_FILES}

clean:
	$(RMDIR) ./package.build
	${RMDIR} package

.PHONY: all package clean


