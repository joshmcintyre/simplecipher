# This file contains a make script for the PkTime application
#
# Author: Josh McIntyre
#

# This block defines makefile variables
SRC_FILE=./src/simplecipher.asm

BUILD_DIR=bin
BUILD_BIN=simplecipher
BUILD_INTER=simplecipher.o

ASM=nasm
ASM_FLAGS=-f elf -o
CC=gcc
CC_FLAGS=-m32 -no-pie -o

# This rule builds the utility
build: $(SRC_FILES)
	mkdir -p $(BUILD_DIR)
	$(ASM) $(ASM_FLAGS) $(BUILD_DIR)/$(BUILD_INTER) $(SRC_FILE)
	$(CC) $(CC_FLAGS) $(BUILD_DIR)/$(BUILD_BIN) $(BUILD_DIR)/$(BUILD_INTER)

# This rule cleans the build directory
clean: $(BUILD_DIR)
	rm $(BUILD_DIR)/* 
	rmdir $(BUILD_DIR)
