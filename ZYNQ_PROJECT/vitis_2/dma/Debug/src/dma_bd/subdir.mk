################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/dma_bd/dma_bd.c 

OBJS += \
./src/dma_bd/dma_bd.o 

C_DEPS += \
./src/dma_bd/dma_bd.d 


# Each subdirectory must supply rules for building sources it contributes
src/dma_bd/%.o: ../src/dma_bd/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -IC:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/platform/export/platform/sw/platform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


