MAKEFLAGS += --no-print-directory

ROOT_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

export

.PHONY: help
help:
	@. ${ROOT_DIR}/make/$@.sh

.PHONY: test
test:
	@echo run test suites
