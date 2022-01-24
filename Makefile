
MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MK_DIR := $(dir $(MK_PATH))

TOOLCHAIN=arm-none-eabi-

AS=$(TOOLCHAIN)as
LD=$(TOOLCHAIN)ld
CP=$(TOOLCHAIN)objcopy

AS_OPT=-g -march=armv6-m -alm
LD_OPT=--gc-sections
CP_OPT=--strip-all

LD_PATH=$(MK_DIR)cfg/linker
SRC_PATH=$(MK_DIR)src
BIN_PATH=$(MK_DIR)bin
OBJ_PATH=${BIN_PATH}/obj

# Get list of sources and output files
SRCS = $(wildcard *.s $(foreach fd, $(SRC_PATH), $(fd)/*.s))
OBJS = $(addprefix $(OBJ_PATH)/, $(notdir $(SRCS:s=o)))

.PHONY: all
all: echoes clean $(OBJS)
	$(LD) $(LD_OPT) $(OBJS) -o $(BIN_PATH)/executable.elf -T $(LD_PATH)/sram.ld
	$(CP) $(CP_OPT) $(BIN_PATH)/executable.elf $(BIN_PATH)/executable.hex

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.s
	$(AS) $(AS_OPT) -o $(OBJ_PATH)/$(@F) $<

clean:
	rm -rf ${OBJ_PATH}/*.o
	rm -rf ${BIN_PATH}/*.elf
	rm -rf ${BIN_PATH}/*.hex

echoes:
	@echo "SRCS files: $(SRCS)"
	@echo "OBJS files: $(OBJS)"
	@echo "LD_PATH : $(LD_PATH)"
	@echo "SRC_PATH : $(SRC_PATH)"
	@echo "BIN_PATH : $(BIN_PATH)"
	@echo "OBJ_PATH : $(OBJ_PATH)"
