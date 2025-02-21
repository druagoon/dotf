.DEFAULT_GOAL := help

SHELL := bash

# BASE_DIR := $(shell cd "`dirname "$0"`" >/dev/null 2>&1 && pwd)

##@ Build

.PHONY: clean
clean: ## Clean up
	@argc clean

.PHONY: build
build: ## Compile and build binaries
	@argc build

.PHONY: dist
dist: ## Distribute binaries
	@argc dist

##@ Test

.PHONY: test
test: ## Test binaries
	@argc test

##@ Release

.PHONY: release
release: clean build test dist ## Release binaries

##@ General

.PHONY: help
help: ## Display help messages
	@./.make/help "$(MAKEFILE_LIST)"
