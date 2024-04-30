pipeline {
    agent { label 'Linux' } 
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        ECR_REPO = '621627302500.dkr.ecr.us-east-1.amazonaws.com'
        AWS_REGION = 'us-east-1'
        DOCKER_SERVER = 'Jenkins-Project-Docker'
    }
    stages {
        stage('Create Infrastructure') {
            steps {
                dir("Solution-Files/Task1/Terraform") {
                    script {
                        // sh(script: "aws ec2 create-key-pair --key-name ${params.Environment}-Keypair --region ${AWS_REGION} --query 'KeyMaterial' --output text > ${params.Environment}-Keypair.pem", returnStdout: true)
                        // sh(script: "sudo chmod 400 ${params.Environment}-Keypair.pem", returnStatus: true)
                        sh(script: "echo -var 'instance_type=${params.InstanceType}' -var 'ami=${params.AMI}' -var key_name=${params.Environment}-Keypair} > test.txt")
                        sh(script: "cat test.txt")
                        // sh(script: "terraform init", returnStdout: true)
                        // sh(script: "terraform plan", returnStdout: true)
                        // sh(script: "terraform apply -auto-approve", returnStdout: true)
                    }
                }
            }
        }
    }
    post {
        failure {
            sh(script: "aws ec2 delete-key-pair --key-name ${params.Environment}-Keypair", returnStdout: true)
        }
    }
}