pipeline {
    agent { label 'Linux' } 
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        AWS_REGION = 'us-east-1'
        TAGS = "{\"Name\":\"Blue-Rental-${params.Environment}\"}"
    }
    stages {
        stage('Example Stage') {
            steps {
                script {
                    if (params.Environment == 'DEV') {
                        echo "Deploying to Developer environment"
                        // Add your steps for deploying to Dev environment
                    } else if (params.Environment == 'QA') {
                        echo "Deploying to QA environment"
                        // Add your steps for deploying to QA environment
                    } else if (params.Environment == 'PROD') {
                        echo "Deploying to Production environment"
                        // Add your steps for deploying to Production environment
                    } else if (params.Environment == 'STAG') {
                        echo "Deploying to Staging environment"
                        // Add your steps for deploying to Production environment
                    } else {
                        error "Invalid environment selected"
                    }
                }
            }
        }
        // stage('Create Infrastructure') {
        //     steps {
        //         dir("Solution-Files/Task1/Terraform") {
        //             script {
        //                 sh(script: "aws ec2 create-key-pair --key-name ${params.Environment}-Keypair --region ${AWS_REGION} --query 'KeyMaterial' --output text > ${params.Environment}-Keypair.pem", returnStdout: true)
        //                 sh(script: "sudo chmod 400 ${params.Environment}-Keypair.pem", returnStatus: true)
        //                 sh(script: "terraform init", returnStdout: true)
        //                 sh(script: "terraform plan", returnStdout: true)
        //                 sh(script: "terraform apply -auto-approve \
        //                             -var tags='${TAGS}' \
        //                             -var key_name=${params.Environment}-Keypair \
        //                             -var environment=${params.Environment} \
        //                             -var instance_type=${params.InstanceType} \
        //                             -var ami=${AMI}", returnStdout: true)
        //             }
        //         }
        //     }
        // }
    }
    post {
        failure {
            dir("Solution-Files/Task1/Terraform") {
                sh(script: "aws ec2 delete-key-pair --key-name ${params.Environment}-Keypair", returnStdout: true)
                sh(script: "terraform destroy -auto-approve", returnStdout: true)
            }
        }
    }
}