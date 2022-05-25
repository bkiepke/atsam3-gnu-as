
MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MK_DIR := $(dir $(MK_PATH))

TOOLCHAIN := arm-none-eabi-
OUTFILE := firmware

AS := $(TOOLCHAIN)as
LD := $(TOOLCHAIN)ld
OC := $(TOOLCHAIN)objcopy
OD := $(TOOLCHAIN)objdump
SZ := ${TOOLCHAIN}size
AR := $(TOOLCHAIN)ar
NM := $(TOOLCHAIN)nm

LD_PATH := $(MK_DIR)cfg/linker
SRC_PATH := $(MK_DIR)src
INC_DIRS := $(shell find $(SRC_PATH) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))
BIN_PATH := $(MK_DIR)bin
OBJ_PATH := ${BIN_PATH}/obj

AS_OPT := -ggdb -march=armv7-m -mcpu=cortex-m3 -mthumb $(INC_FLAGS) #-alm
LD_OPT := --gc-sections --print-memory-usage -Map="$(BIN_PATH)/$(OUTFILE).map" --cref
#CP_OPT=--strip-all
OC_OPT := -S -O ihex
OD_OPT := -S
SZ_OPT := 
AR_OPT := -r
NM_OPT := --numeric-sort --print-size --line-numbers --print-file-name

# Get list of sources and output files
SRCS := $(wildcard *.s $(foreach fd, $(INC_DIRS), $(fd)/*.s))
#OBJS := $(addprefix $(OBJ_PATH)/, $(notdir $(SRCS:s=o)))
OBJS := $(SRCS:%.s=%.o)

.PHONY: all

all: build

build: echoes clean create $(OBJS)
	@echo "Building ..."
# either use SRAM
	$(LD) $(LD_OPT) $(addprefix $(OBJ_PATH)/,$(notdir $(OBJS))) -o $(BIN_PATH)/$(OUTFILE).elf -T $(LD_PATH)/sram.ld
# or use FLASH
#	$(LD) $(LD_OPT) $(addprefix $(OBJ_PATH)/,$(notdir $(OBJS))) -o $(BIN_PATH)/$(OUTFILE).elf -T $(LD_PATH)/flash.ld
	$(OC) $(OC_OPT) $(BIN_PATH)/$(OUTFILE).elf $(BIN_PATH)/$(OUTFILE).hex
	$(OD) $(OD_OPT) $(BIN_PATH)/$(OUTFILE).elf > $(BIN_PATH)/$(OUTFILE).lst
	$(NM) $(NM_OPT) $(BIN_PATH)/$(OUTFILE).elf > $(BIN_PATH)/$(OUTFILE).sym
	$(SZ) $(SZ_OPT) $(BIN_PATH)/$(OUTFILE).elf
	@echo "... done"

%.o: %.s
	@echo "Assembling $(OBJ_PATH)/$(@F) from $< ..."
	$(AS) $(AS_OPT) -o $(OBJ_PATH)/$(@F) $<
	@echo "... done"

clean:
	@echo "Clean up old files beneath build directory"
	rm -rf ${OBJ_PATH}/*
	rm -rf ${BIN_PATH}/*
	@echo "... done"

create:
	@echo "Create build directory ${OBJ_PATH}"
	mkdir -p ${OBJ_PATH}
	@echo "... done"

echoes:
	@echo "Will use the following pathes and files"
	@echo "SRCS files: $(SRCS)"
	@echo "OBJS files: $(OBJS)"
	@echo "LD_PATH : $(LD_PATH)"
	@echo "SRC_PATH : $(SRC_PATH)"
	@echo "BIN_PATH : $(BIN_PATH)"
	@echo "OBJ_PATH : $(OBJ_PATH)"
