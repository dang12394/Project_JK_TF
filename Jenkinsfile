pipeline {
    agent any
    stage{
        stage('Clone') {
            steps {
                git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/dang12394/Project_JK_TF.git'
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