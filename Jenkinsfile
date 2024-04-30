pipeline {
    agent { label 'Linux' } 
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        AWS_REGION = 'us-east-1'
        ENV = "${params.Environment}"
        TAGS = "{\"Name\":\"Blue-Rental-${params.Environment}\"}"
        AMI = "${params.AMI}"
        INSTANCE_TYPE = "${params.InstanceType}"
        KEY_NAME = "${params.Environment}-Keypair"
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
                            sh "terraform plan"
                            sh "terraform apply -auto-approve \
                                        -var tags='${TAGS}' \
                                        -var key_name='${KEY_NAME}' \
                                        -var environment='${ENV}' \
                                        -var instance_type='${INSTANCE_TYPE}' \
                                        -var ami='${AMI}'"
                        }
                    } else if (params.Environment == 'QA') {
                        dir("Solution-Files/Task1/Terraform/QA") {
                            echo "Creating Resources on QA Environment"
                            sh(script: "terraform init", returnStdout: true)
                            sh "terraform plan"
                            sh "terraform apply -auto-approve \
                                        -var tags='${TAGS}' \
                                        -var key_name='${KEY_NAME}' \
                                        -var environment='${ENV}' \
                                        -var instance_type='${INSTANCE_TYPE}' \
                                        -var ami='${AMI}'"
                        }
                    } else if (params.Environment == 'PROD') {
                        dir("Solution-Files/Task1/Terraform/PROD") {
                            echo "Creating Resources on Production Environment"
                            sh(script: "terraform init", returnStdout: true)
                            sh "terraform plan \
                                        -var tags='${TAGS}' \
                                        -var key_name='${KEY_NAME}' \
                                        -var environment='${ENV}' \
                                        -var instance_type='${INSTANCE_TYPE}' \
                                        -var ami='${AMI}'"
                            sh "terraform refresh"  
                            sh "terraform apply -auto-approve \
                                        -var tags='${TAGS}' \
                                        -var key_name='${KEY_NAME}' \
                                        -var environment='${ENV}' \
                                        -var instance_type='${INSTANCE_TYPE}' \
                                        -var ami='${AMI}'"
                        }
                    } else if (params.Environment == 'STAG') {
                        dir("Solution-Files/Task1/Terraform/STAG") {
                            echo "Creating Resources on Staging Environment"
                            sh(script: "terraform init", returnStdout: true)
                            sh "terraform plan \
                                        -var tags='${TAGS}' \
                                        -var key_name='${KEY_NAME}' \
                                        -var environment='${ENV}' \
                                        -var instance_type='${INSTANCE_TYPE}' \
                                        -var ami='${AMI}'"
                            sh "terraform refresh"  
                            sh "terraform apply -auto-approve \
                                        -var tags='${TAGS}' \
                                        -var key_name='${KEY_NAME}' \
                                        -var environment='${ENV}' \
                                        -var instance_type='${INSTANCE_TYPE}' \
                                        -var ami='${AMI}'"
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