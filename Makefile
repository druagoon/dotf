.DEFAULT_GOAL := help

SHELL := bash

# BASE_DIR := $(shell cd "`dirname "$0"`" >/dev/null 2>&1 && pwd)

##@ Project

.PHONY: motto
motto: ## Show motto
	@if [[ -f .motto ]]; then cat .motto; fi

##@ Cli

.PHONY: dotf
dotf: ## Build `dotf` cli
	@argc release

##@ General

.PHONY: help
help: ## Display help messages
	@./.make/help "$(MAKEFILE_LIST)"
