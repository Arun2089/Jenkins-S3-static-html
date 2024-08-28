pipeline {
    agent any

    environment {
        
        AWS_REGION = 'ap-south-1'
       
    }

    stages {
        stage('Checkout') {
            steps {
             
                git branch: 'main', url: 'https://github.com/Arun2089/Jenkins-S3-static-html.git'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                   
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                  
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input 'Approve Terraform Apply?'
                script {
                 
                    sh 'terraform apply -auto-approve'
                }
            }
        }

    

 
}
