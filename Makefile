.PHONY: build main simple bundle static test

V ?= v
BIN_DIR := ./bin
BUILD_BIN := $(BIN_DIR)/bash2v
STATIC_BIN := $(BIN_DIR)/bash2v_static

build: main

main:
	mkdir -p $(BIN_DIR)
	$(V) -prod -o $(BUILD_BIN) ./cmd/bash2v

simple:
	mkdir -p $(BIN_DIR)
	$(V) -o $(BUILD_BIN) ./cmd/bash2v

bundle:
	mkdir -p $(BIN_DIR)
	$(V) -prod -o $(STATIC_BIN) ./cmd/bash2v

static: bundle

test:
	$(V) test ./bash2v
	$(V) test ./tests
