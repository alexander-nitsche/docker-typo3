SHELL := /bin/bash

BRANCH ?= $$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

.PHONY: check build install start stop

check:
	@if [ ! -f ".env" ]; then \
		echo "Missing environment file. Copy .env-template to .env and adapt." && exit 1; \
	fi;

build: check
	@echo "Build TYPO3 Docker images [branch: $(BRANCH)]"
	@docker-compose -f local.yml build --force-rm

install: check
	@echo "Install TYPO3"
	@mkdir -p typo3
	@docker-compose -f admin.yml run --rm install-typo3-composer

start: check
	@echo "Bring up TYPO3 project alexander-nitsche-website-2020 [branch: $(BRANCH)]"
	@docker-compose -f local.yml up

stop:
	@echo "Bring down TYPO3 project alexander-nitsche-website-2020"
	@docker-compose -f local.yml down
