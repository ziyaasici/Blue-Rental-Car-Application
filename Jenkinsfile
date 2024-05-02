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
        COUNT = "${params.InstanceCount}"
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
                                    -var key_name='${KEY_NAME}' \
                                    -var environment='${ENV}' \
                                    -var instance_type='${INSTANCE_TYPE}' \
                                    -var ami='${AMI}' \
                                    -var ec2_count=${COUNT}", returnStdout: true)
                    }
                }
            }
        }
        stage('Wait for Resources') {
            steps {
                script {
                    echo 'Waiting for resources to get ready'
                    id = sh(script: "aws ec2 describe-instances --filters Name=tag-value,Values='Blue-Rental-${params.Environment}' Name=instance-state-name,Values=running --query Reservations[*].Instances[*].[InstanceId] --output text",  returnStdout:true).trim()
                    sh 'aws ec2 wait instance-status-ok --instance-ids $id'
                }
            }
        }
        // stage('Wait for EC2s') {
        //     steps {
        //         script {
        //             def awsCommand = "aws ec2 describe-instances --filters Name=tag:Name,Values='Blue-Rental-${params.Environment}' Name=instance-state-name,Values=running --region ${AWS_REGION} --query 'Reservations[*].Instances[*].InstanceId' --output text"
                    
        //             def instanceId = sh(script: awsCommand, returnStdout: true).trim()
        //             println "EC2 Instance ID: ${instanceId}"
                    
        //             def ec2State = ''
        //             timeout(time: 10, unit: 'MINUTES') {
        //                 while (ec2State != 'running') {
        //                     def instanceStateCmd = "aws ec2 describe-instance-status --instance-ids ${instanceId} --region ${AWS_REGION} --query 'InstanceStatuses[*].InstanceState.Name' --output text"
        //                     ec2State = sh(script: instanceStateCmd, returnStdout: true).trim()
        //                     if (ec2State != 'running') {
        //                         println "EC2 instance is not running yet. Waiting..."
        //                         sleep time: 30, unit: 'SECONDS'
        //                     }
        //                 }
        //             }
        //         }
        //     }
        // }
        stage('Ansible Configurations') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    credentialsId: 'AWS-Jenkins',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    dir("Solution-Files/Task2/Ansible/${params.Environment}") {
                        ansiblePlaybook(
                            playbook: 'playbook.yml',
                        )
                    }
                }
            }
        }
    }
    // post {
    //     success {
    //         timeout(time: 5, unit: 'MINUTES') {
    //             dir("Solution-Files/Task1/Terraform") {
    //                 sh(script: "aws ec2 delete-key-pair --key-name ${params.Environment}-Keypair", returnStdout: true)
    //                 sh(script: "terraform destroy -auto-approve", returnStdout: true)
    //             }
    //         }
    //     }
    //     failure {
    //         dir("Solution-Files/Task1/Terraform") {
    //             sh(script: "aws ec2 delete-key-pair --key-name ${params.Environment}-Keypair", returnStdout: true)
    //             sh(script: "terraform destroy -auto-approve", returnStdout: true)
    //         }
    //     }
    // }
}