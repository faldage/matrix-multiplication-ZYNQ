
/*
 *DMA redefines
 */
#define MAX_DMA_LEN		   0x4000000      /* DMA max length in byte */
#define DMA_DEV_ID		   XPAR_AXIDMA_0_DEVICE_ID
#define S2MM_INTR_ID       XPAR_FABRIC_AXI_DMA_0_S2MM_INTROUT_INTR
#define MM2S_INTR_ID       XPAR_FABRIC_AXI_DMA_0_MM2S_INTROUT_INTR

/*
 *DMA BD defines
 */
#define BD_COUNT         4


#define DATA_LENTH_1  301*1024
#define DATA_LENTH_2  21*1024
//#define DATA_LENTH_2  301*1024

