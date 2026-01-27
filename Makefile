MAKEFLAGS += --no-print-directory

SHELL := /bin/bash

FUNCSHIONAL_ROOT_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

define source_script
	. ${FUNCSHIONAL_ROOT_DIR}make/$(1).sh
endef

export

.PHONY: help
help:
	@$(call source_script,$@)

.PHONY: init
init:
	@$(call source_script,$@)

.PHONY: test
test: init
	@$(call source_script,$@)

.PHONY: watch
watch: init
	@$(call source_script,$@)
