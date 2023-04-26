.PHONY: cicd clean-cicd setup lint check uuid

UNAME_S := $(shell uname -s)

cicd:
ifeq ($(CICD), argo)
	@echo "[!] Placeholder for ArgoCD actions"
endif
ifeq ($(CICD), bitbucket)
	@cp .cicd/bitbucket/bitbucket-pipelines.yml .
endif
ifeq ($(CICD), concourse)
	@echo "[!] Placeholder for Concourse actions"
endif
ifeq ($(CICD), earthly)
	@echo "[!] Placeholder for Earthly actions"
endif
ifeq ($(CICD), github)
	@mkdir -p .github/workflows
	@cp .cicd/github/workflows/check-rules.yml .github/workflows/
endif
ifeq ($(CICD), gitlab)
	@cp .cicd/gitlab/gitlab-ci.yml .gitlab-ci.yml
endif
ifeq ($(CICD), jenkins)
	@echo "[!] Placeholder for Jenkins actions"
endif
	@$(MAKE) clean-cicd

clean-cicd:
	@echo "[+] Removing .cicd directory..."
	@rm -rf .cicd

setup:
	@pipenv install sigma-cli sigmatools
	@pipenv shell

lint:
	@yamllint -d relaxed rules/

check:
	@sigma check -i rules/

uuid:
ifeq ($(UNAME_S), Linux)
	@uuidgen
endif
ifeq ($(UNAME_S), Darwin)
	@uuidgen | tr A-F a-f
endif
