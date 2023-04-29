pipeline {
    agent any
    stages {
        stage('yamllint-rules') {
            when {
                anyOf {
                    changeset "Jenkinsfile"
                    changeset "rules/**/*.yml"
                }
            }
            agent {
                docker { image 'pipelinecomponents/yamllint' }
            }
            steps {
                sh 'yamllint -d relaxed rules/'
            }
        }
        stage('sigma-check-rules') {
            when {
                anyOf {
                    changeset "Jenkinsfile"
                    changeset "rules/**/*.yml"
                }
            }
            agent {
                docker { image 'python:3.11' }
            }
            steps {
                sh 'pip install sigma-cli'
                sh 'sigma check -i rules/'
            }
        }
    }
}
