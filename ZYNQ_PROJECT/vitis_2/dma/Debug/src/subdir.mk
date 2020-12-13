################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/lwip_app.c \
../src/main.c \
../src/platform.c \
../src/platform_zynq.c \
../src/zynq_interrupt.c 

OBJS += \
./src/lwip_app.o \
./src/main.o \
./src/platform.o \
./src/platform_zynq.o \
./src/zynq_interrupt.o 

C_DEPS += \
./src/lwip_app.d \
./src/main.d \
./src/platform.d \
./src/platform_zynq.d \
./src/zynq_interrupt.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -IC:/Users/Administrator/smvm-hlx/ZYNQ_PROJECT/vitis_2/platform/export/platform/sw/platform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


