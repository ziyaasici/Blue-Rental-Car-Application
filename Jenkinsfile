pipeline {
    agent { label 'Linux' } 
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        ECR_REPO = '621627302500.dkr.ecr.us-east-1.amazonaws.com'
        AWS_REGION = 'us-east-1'
        DOCKER_SERVER = 'Jenkins-Project-Docker'
    }
    stages {
        stage {
            steps {
                echo 'Test'
            }
        }
    }
}