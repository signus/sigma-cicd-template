.PHONY: setup check lint uuid

UNAME_S := $(shell uname -s)

setup:
	pipenv install sigma-cli sigmatools
	pipenv shell

check:
	@sigma check -i rules/

lint:
	@yamllint -d relaxed rules/

uuid:
ifeq ($(UNAME_S), Linux)
	@uuidgen
endif
ifeq ($(UNAME_S), Darwin)
	@uuidgen | tr A-F a-f
endif
