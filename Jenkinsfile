pipeline {

    agent { label 'Linux' } 

    parameters {
        choice(name: 'Environment', choices: ['DEV', 'PROD', 'QA', 'STAG'], description: 'Environment to create resources on')
        choice(name: 'InstanceType', choices: ['t2.micro', 't3.medium'], description: 'Instance Type for EC2')
        choice(name: 'AMI', choices: ['ami-07caf09b362be10b8', 'ami-0a1179631ec8933d7'], description: 'AMI for EC2')
        choice(name: 'InstanceCount', choices: ['1', '2', '3', '4', '5'], description: 'Number of EC2 instances to deploy')
    }

    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        AWS_REGION = 'us-east-1'
        TAGS = "{\"Name\":\"Blue-Rental-${params.Environment}\"}"
        AWS_ACCOUNT_ID=sh(script:'export PATH="$PATH:/usr/local/bin" && aws sts get-caller-identity --query Account --output text', returnStdout:true).trim()
        ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        APP_REPO_NAME = "ziyaasici/blue-rental-car"
    }

    stages {
        stage('Create KeyPair') {
            steps {
                script {
                    sh(script: "aws ec2 describe-key-pairs --key-names ${params.Environment}-Keypair --region ${AWS_REGION} --query 'KeyPairs[0]' || \
                                aws ec2 create-key-pair --key-name ${params.Environment}-Keypair --region ${AWS_REGION} --query 'KeyMaterial' \
                                --output text > ${params.Environment}-Keypair.pem", returnStdout: true)
                    sh(script: "sudo chmod 400 ${params.Environment}-Keypair.pem", returnStatus: true)
                }
            }
        }
        stage('Create Resources') {
            steps {
                script {
                    dir("Solution-Files/Task1/Terraform") {
                        sh(script: "terraform workspace select ${params.Environment} || terraform workspace new ${params.Environment}", returnStdout: true)
                        sh(script: "terraform init", returnStdout: true)
                        sh(script: "terraform apply -auto-approve \
                                    -var tags='${TAGS}' \
                                    -var key_name='${params.Environment}-Keypair' \
                                    -var environment='${params.Environment}' \
                                    -var instance_type='${params.InstanceType}' \
                                    -var ami='${params.AMI}' \
                                    -var ec2_count=${params.InstanceCount}", returnStdout: true)
                    }
                }
            }
        }
        stage('Wait for Resources') {
            steps {
                script {
                    echo 'Waiting for resources to get ready'
                    id = sh(script: "aws ec2 describe-instances --filters Name=tag-value,Values='Blue-Rental-${params.Environment}' \
                                    Name=instance-state-name,Values=running --query Reservations[*].Instances[*].[InstanceId] --output text",  returnStdout:true).trim()
                    sh 'aws ec2 wait instance-status-ok --instance-ids $id'
                }
            }
        }
        stage('Create ECR') {
            steps {
                script {
                    sh(script: "aws ecr describe-repositories --region ${AWS_REGION} --repository-names ${APP_REPO_NAME} \
                                || aws ecr create-repository --repository-name ${APP_REPO_NAME} --image-tag-mutability IMMUTABLE", returnStatus: true)
                    sh(script: "aws ecr describe-repositories --region ${AWS_REGION} --repository-names ${APP_REPO_NAME} \
                                || aws ecr create-repository --repository-name ${APP_REPO_NAME} --image-tag-mutability IMMUTABLE", returnStatus: true)
                    sh(script: "aws ecr describe-repositories --region ${AWS_REGION} --repository-names ${APP_REPO_NAME} \
                                || aws ecr create-repository --repository-name ${APP_REPO_NAME} --image-tag-mutability IMMUTABLE", returnStatus: true)
                }
            }
        }
        stage('Build Images') {
            steps {
                // script {
                //     env.NODE_IP = sh(script: 'terraform output -raw ec2-public-ips', returnStdout:true).trim()
                // }   
                // sh 'echo ${NODE_IP}'
                // sh 'echo "REACT_APP_BASE_URL=http://${NODE_IP}:5000/" > ./react/client/.env'
                // sh 'cat ./Solution-Files/Task3/apps/bluerentalcars-frontend/.env'
                dir("Solution-Files/Task3/apps/postgresql") {
                    script {
                        sh(script: 'docker build --force-rm -t "$ECR_REGISTRY/$APP_REPO_NAME:postgresqlv1" .', returnStdout: true)
                    }
                }
                dir("Solution-Files/Task3/apps/bluerentalcars-frontend") {
                    script {
                        sh(script: 'docker build --force-rm -t "$ECR_REGISTRY/$APP_REPO_NAME:reactv1" .', returnStdout: true)
                    }
                }
                dir("Solution-Files/Task3/apps/bluerentalcars-backend") {
                    script {
                        sh(script: 'docker build --force-rm -t "$ECR_REGISTRY/$APP_REPO_NAME:javav1" .', returnStdout: true)
                    }
                }
            }
        }
        stage('Push Images') {
            steps {
                script {
                    sh(script: 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin "$ECR_REGISTRY"', returnStdout: true)
                    sh(script: 'docker push "$ECR_REGISTRY/$APP_REPO_NAME:postgresqlv1"', returnStdout: true)
                    sh(script: 'docker push "$ECR_REGISTRY/$APP_REPO_NAME:reactv1"', returnStdout: true)
                    sh(script: 'docker push "$ECR_REGISTRY/$APP_REPO_NAME:javav1"', returnStdout: true)
                }
            }
        }
        stage('Ansible Configurations') {
            steps {
                dir("Solution-Files/Task2/Ansible/") {
                    ansiblePlaybook(
                        playbook: "${params.Environment}-playbook.yml", 
                        extras: "--private-key=${WORKSPACE}/${params.Environment}-Keypair.pem"
                    )
                }
            }
        }
    }


    post {
        success {
            timeout(time: 5, unit: 'MINUTES') {
                dir("Solution-Files/Task1/Terraform") {
                    sh(script: "aws ec2 delete-key-pair --key-name ${params.Environment}-Keypair", returnStdout: true)
                    // sh(script: "aws ecr delete-repository --repository-name ${APP_REPO_NAME} --force", returnStdout: true)
                    // sh(script: "docker image prune -af", returnStdout: true)
                    sh(script: "terraform destroy -auto-approve", returnStdout: true)
                }
            }
        }
        failure {
            dir("Solution-Files/Task1/Terraform") {
                sh(script: "aws ec2 delete-key-pair --key-name ${params.Environment}-Keypair", returnStdout: true)
                // sh(script: "aws ecr delete-repository --repository-name ${APP_REPO_NAME} --force", returnStdout: true)
                // sh(script: "docker image prune -af", returnStdout: true)
                sh(script: "terraform destroy -auto-approve", returnStdout: true)
            }
        }
    }
}