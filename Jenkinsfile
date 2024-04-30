pipeline {
    agent { label 'Linux' } 
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        AWS_REGION = 'us-east-1'
        TAGS = "{\"Name\":\"Blue-Rental-${params.Environment}\"}"
    }
    stages {
        stage('Create KeyPair') {
            steps {
                script {
                    sh(script: "aws ec2 create-key-pair --key-name ${params.Environment}-Keypair --region ${AWS_REGION} --query 'KeyMaterial' --output text > ${params.Environment}-Keypair.pem", returnStdout: true)
                    sh(script: "sudo chmod 400 ${params.Environment}-Keypair.pem", returnStatus: true)
                    sh 'pwd'
                }
            }
        }
        stage('Create Resources') {
            steps {
                script {
                    if (params.Environment == 'DEV') {
                        dir("Solution-Files/Task1/Terraform/DEV") {
                            echo "Creating Resources on Developer Environment"
                            sh(script: "terraform init", returnStdout: true)
                            sh(script: "terraform plan", returnStdout: true)
                            sh(script: "terraform apply -auto-approve \
                                        -var tags='${TAGS}' \
                                        -var key_name='${params.Environment}-Keypair' \
                                        -var environment=${params.Environment} \
                                        -var instance_type=${params.InstanceType} \
                                        -var ami=${AMI}", returnStdout: true)
                        }
                    } else if (params.Environment == 'QA') {
                        dir("Solution-Files/Task1/Terraform/QA") {
                            echo "Creating Resources on QA Environment"
                            sh(script: "terraform init", returnStdout: true)
                            sh(script: "terraform plan", returnStdout: true)
                            sh(script: "terraform apply -auto-approve \
                                        -var tags='${TAGS}' \
                                        -var key_name='${params.Environment}-Keypair' \
                                        -var environment=${params.Environment} \
                                        -var instance_type=${params.InstanceType} \
                                        -var ami=${AMI}", returnStdout: true)
                        }
                    } else if (params.Environment == 'PROD') {
                        dir("Solution-Files/Task1/Terraform/PROD") {
                            echo "Creating Resources on Production Environment"
                            sh(script: "terraform init", returnStdout: true)
                            sh(script: "terraform plan", returnStdout: true)
                            sh(script: "terraform apply -auto-approve \
                                        -var tags='${TAGS}' \
                                        -var key_name='${params.Environment}-Keypair' \
                                        -var environment=${params.Environment} \
                                        -var instance_type=${params.InstanceType} \
                                        -var ami=${AMI}", returnStdout: true)
                        }
                    } else if (params.Environment == 'STAG') {
                        dir("Solution-Files/Task1/Terraform/STAG") {
                            echo "Creating Resources on Staging Environment"
                            sh(script: "terraform init", returnStdout: true)
                            sh(script: "terraform plan", returnStdout: true)
                            sh(script: "terraform apply -auto-approve \
                                        -var tags='${TAGS}' \
                                        -var key_name='${params.Environment}-Keypair' \
                                        -var environment=${params.Environment} \
                                        -var instance_type=${params.InstanceType} \
                                        -var ami=${AMI}", returnStdout: true)
                        }
                    } else {
                            error "Invalid Environment Selected!"
                        }
                }
            }
        }
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