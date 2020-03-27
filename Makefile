TARGET := riscv64-unknown-elf
CC := $(TARGET)-gcc
LD := $(TARGET)-gcc
CFLAGS := -Os -DCKB_NO_MMU -D__riscv_soft_float -D__riscv_float_abi_soft
LDFLAGS := -lm -Wl,-static -fdata-sections -ffunction-sections -Wl,--gc-sections -Wl,-s
CURRENT_DIR := $(shell pwd)
DOCKER_BUILD := docker run --rm -it -v $(CURRENT_DIR):/src nervos/ckb-riscv-gnu-toolchain:xenial bash -c
CIRCUITS_SRC := $(CURRENT_DIR)/pkg
RUN_SRC := $(CURRENT_DIR)/c

circuits:
	$(CC) -I$(CIRCUITS_SRC) $(CIRCUITS_SRC)/countduckula.c $(CIRCUITS_SRC)/wasm-rt-impl.c $(RUN_SRC)/test_circuits.c $(LDFLAGS) -o $(CIRCUITS_SRC)/test_circuits

circuits_docker:
	$(DOCKER_BUILD) "cd /src && make circuits"
