#!/bin/bash

#GCC=arm-none-eabi-gcc
AS=arm-none-eabi-as
LD=arm-none-eabi-ld
CP=arm-none-eabi-objcopy

AS_OPT="-g -march=armv6-m -alm"
#GCC_OPT="-g -Wa,-march=armv6-m,-mcpu=cortex-m3,-alm"
LD_OPT=--gc-sections
CP_OPT=--strip-all

SRC_PATH=src
BIN_PATH=bin
OBJ_PATH=${BIN_PATH}/obj
LST_PATH=${BIN_PATH}/lst

${AS} ${AS_OPT} ${SRC_PATH}/startup.s -o ${OBJ_PATH}/startup.o 
${AS} ${AS_OPT} ${SRC_PATH}/app.s -o ${OBJ_PATH}/app.o
#${AS} ${AS_OPT} ${SRC_PATH}/app.s -o ${OBJ_PATH}/app.o
#echo ${GCC} ${GCC_OPT} ${SRC_PATH}/*.s -o ${BIN_PATH}/executable.elf
${LD} ${LD_OPT} ${OBJ_PATH}/startup.o ${OBJ_PATH}/app.o -o ${BIN_PATH}/executable.elf -T ${SRC_PATH}/sram.ld
#${LD} ${LD_OPT} ${OBJ_PATH}/*.o -o ${BIN_PATH}/executable.elf
${CP} ${CP_OPT} ${BIN_PATH}/executable.elf ${BIN_PATH}/executable.hex

exit 0