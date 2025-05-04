pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'eeirq/cloudkiss:latest'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Eeirq/CloudKiss.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
                sh 'docker push ${DOCKER_IMAGE}'
            }
        }
        stage('Deploy on EC2') {
            steps {
                sh 'ssh -i "CloudStar.pem" ec2-user@ec2-3-134-207 "docker pull ${DOCKER_IMAGE} && docker run -d -p 8000:8000 ${DOCKER_IMAGE}"'
            }
        }
    }
}
