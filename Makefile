# Makefile
# Operations for initializing the repository as well as for locally replicating pipeline actions
# TODO: Add steps for forcing rules into branches based on statuses
# TODO: Add absolute pathing for cicd target

.PHONY: cicd clean-cicd setup lint check uuid

UNAME_S := $(shell uname -s)

init-cicd:
	@echo "[+] Initializing ${CICD}..."
#ifeq ($(CICD), argo)
#endif
ifeq ($(CICD), bitbucket)
	cp .cicd/bitbucket/bitbucket-pipelines.yml .
endif
#ifeq ($(CICD), concourse)
# TODO: Figure out what steps if any are required - concourse operates by uploads
# NOTE: Optionally call fly to upload the pipeline if authed
#endif
#ifeq ($(CICD), drone)
#endif
ifeq ($(CICD), earthly)
	cp .cicd/eartly/Earthfile Earthfile
endif
ifeq ($(CICD), github)
	mkdir -p .github/workflows
	cp .cicd/github/workflows/check-rules.yml .github/workflows/
endif
ifeq ($(CICD), gitlab)
	cp .cicd/gitlab/gitlab-ci.yml .gitlab-ci.yml
endif
ifeq ($(CICD), jenkins)
	cp .cicd/jenkins/Jenkinsfile Jenkinsfile
endif

clean-cicd:
	@echo "[+] Removing .cicd directory..."
	rm -rf .cicd

# TODO: Optionally notify user to install yamllint locally
setup:
	pipenv install sigma-cli sigmatools
	pipenv shell

lint:
	yamllint -d relaxed rules/

check:
	sigma check -i rules/

# Disable command output as we'd likely want to pipe uuidgen output
uuid:
ifeq ($(UNAME_S), Linux)
	@uuidgen
endif
ifeq ($(UNAME_S), Darwin)
	@uuidgen | tr A-F a-f
endif
