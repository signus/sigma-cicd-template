.PHONY: cicd clean-cicd setup lint check uuid

# TODO: Add steps for forcing rules into branches based on statuses

UNAME_S := $(shell uname -s)

cicd:
	@echo "[+] Initializing ${CICD}..."
#ifeq ($(CICD), argo)
#endif
ifeq ($(CICD), bitbucket)
	@cp .cicd/bitbucket/bitbucket-pipelines.yml .
endif
#ifeq ($(CICD), concourse)
#endif
#ifeq ($(CICD), drone)
#endif
#ifeq ($(CICD), earthly)
	#@cp .cicd/eartly/Earthfile Earthfile
#endif
ifeq ($(CICD), github)
	@mkdir -p .github/workflows
	@cp .cicd/github/workflows/check-rules.yml .github/workflows/
endif
ifeq ($(CICD), gitlab)
	@cp .cicd/gitlab/gitlab-ci.yml .gitlab-ci.yml
endif
ifeq ($(CICD), jenkins)
	@cp .cicd/jenkins/Jenkinsfile Jenkinsfile
endif

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
