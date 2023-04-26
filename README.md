# sigma-cicd-template
A template repository for managing a Detection Engineering process around Sigma with Continous Integration/Deployment.

## Usage
1) Clone/fork and keep the CI/CD platform configuration necessary for your pipeline and modify as necessary.
2) Move your rules respository into `rules/` and any relevant configurations for Sigma (CLI/backends/pipelines) into `config/`.

### Initialize
To initialize the repository for the CICD platform of your choice (note that this action is destructive and removes the `.cicd` folder:

```shell
make cicd CICD=concourse
```

### Concourse CI
Install the pipelines using `fly`:

```shell
fly -t "cluster" set-pipeline -p check-rules -c concourse-check-rules.yml
```

## TODO
- [ ] Create Makefile or process for aligning configurations/steps between tools (as much as possible).
- [x] Create Makefile step for initializing repository with specific CI/CD configuration (e.g. `make cicd concourse`)
- [ ] Add configuration for pipelines in ArgoCD
- [x] Add configuration for pipelines in ConcourseCI
- [ ] Add configuration for pipelines in EarthlyCI
- [x] Add configuration for pipelines in GitHub Actions
- [ ] Add configuration for pipelines in Jenkins
- [ ] Add process for implementing validations with solutions like [Automata](https://github.com/3CORESec/Automata) and [Dettectinator](https://github.com/siriussecurity/dettectinator)
- [ ] Add process for aligning output options/integrations for documentation.
- [ ] Add process for storing rule conversion outputs for individual targets:
  - [ ] ElasticSearch
  - [ ] OpenSearch
  - [ ] Splunk
  - [ ] QRadar
  - [ ] InsightIDR
  - [ ] Sentinel/Defender ATP (not currently available as a `sigma-cli` target)
  - [ ] Securonix (not currently available as a `sigma-cli` target)
  - [ ] LogRhythm (not currently available as a `sigma-cli` target)

