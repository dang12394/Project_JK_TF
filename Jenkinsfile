pipeline {
    agent any
    tools {

        terraform 'terraform'
    }
    stages {

        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/dang12394/Project_JK_TF'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform plan -auto-approve'
            }
        }
    }
}