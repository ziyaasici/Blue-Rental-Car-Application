pipeline {
    agent { label 'Linux' } 
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        AWS_REGION = 'us-east-1'
        TAGS = "{\"Name\":\"Blue-Rental-${params.Environment}\"}"
    }
    stages {
        stage('Create Infrastructure') {
            steps {
                dir("Solution-Files/Task1/Terraform") {
                    script {
                        sh(script: "aws ec2 create-key-pair --key-name ${params.Environment}-Keypair --region ${AWS_REGION} --query 'KeyMaterial' --output text > ${params.Environment}-Keypair.pem", returnStdout: true)
                        sh(script: "sudo chmod 400 ${params.Environment}-Keypair.pem", returnStatus: true)
                        sh(script: "terraform init", returnStdout: true)
                        sh(script: "terraform plan", returnStdout: true)
                        sh(script: "terraform apply -auto-approve -var tags='${TAGS}' -var key_name=${params.Environment}-Keypair -var instance_type=${params.InstanceType} -var ami=${AMI}", returnStdout: true)
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