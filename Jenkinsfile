pipeline {
    agent any

    parameters {
        credentials(
            credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl',
            defaultValue: '',
            description: 'The credentials needed to deploy.',
            name: 'bkqs-prod',
            required: true
        )
    }

    stages {

        stage('Started') {
            steps {
                sh 'pwd && ls -la && echo "Started...!"'
            }
        }
        stage('terraform init') {
            steps {
                sh 'echo "init...!"'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: '${bkqs-prod}']]) {
                    sh 'cd environment/prod/s3 && terraform init -reconfigure'
                }
            }
        }
        stage('terraform plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'bkqs-prod1']]) {
                    sh 'cd environment/prod/s3 && terraform plan'
                }            }
        }
        stage('terraform apply') {
            steps {
                input 'Are you sure?'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'bkqs-prod1']]) {
                    sh 'cd environment/prod/s3 && terraform apply --auto-approve'
                }            }
        }
        stage('terraform ended') {
            steps {
                sh 'echo "Ended....!!"'
            }
        }
    }
}