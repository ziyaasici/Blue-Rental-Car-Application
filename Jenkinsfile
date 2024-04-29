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
                dir("Solution-Files/Task1/Terraform/'${params.Environment}'") {
                    script {
                        sh(script: "aws ec2 create-key-pair --key-name ${params.Environment}-Keypair --region ${AWS_REGION} --query 'KeyMaterial' --output text > ${params.Environment}-Keypair.pem", returnStdout: true)
                        sh(script: "sudo chmod 400 ${params.Environment}-Keypair.pem", returnStatus: true)
                        sh(script: "terraform init", returnStdout: true)
                        sh(script: "terraform plan", returnStdout: true)
                        //sh(script: "terraform plan -var vpc_id='${params.vpc_id}' -var ingress_from_port='${params.ingress_from_port}' -var ingress_to_port='${params.ingress_to_port}' -var ingress_protocol='${params.ingress_protocol}' -var ingress_cidr_blocks='${params.ingress_cidr_blocks}'", returnStdout: true)
                        //sh(script: "terraform apply -auto-approve", returnStdout: true)
                    }
                }
            }
        }
    }
}