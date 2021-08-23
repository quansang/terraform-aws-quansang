pipeline {
    agent any

    stages {

        stage('Started') {
            steps {
                sh 'pwd && ls -la && echo "Started...!"'
            }
        }
        stage('terraform init') {
            steps {
                sh 'cd environment/prod/s3 && terraform init'
            }
        }
        stage('terraform plan') {
            steps {
                sh 'cd environment/prod/s3 && terraform plan'
            }
        }
        stage('terraform apply') {
            steps {
                input 'Are you sure?'
                sh 'cd environment/prod/s3 && terraform apply --auto-approve'
            }
        }
        stage('terraform ended') {
            steps {
                sh 'echo "Ended....!!"'
            }
        }
    }
}