pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'eeirq/cloudkiss:latest'
        EC2_HOST = 'your-existing-ec2-public-ip'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Eeirq/CloudKiss.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                sh 'docker build -t ${DOCKER_IMAGE} .'
                sh 'docker push ${DOCKER_IMAGE}'
            }
        }
        stage('Deploy on Existing EC2 Instance') {
            steps {
                sh '''
                    ssh -i "CloudStar.pem" ec2-user@${EC2_HOST} <<EOF
                    docker pull ${DOCKER_IMAGE}
                    docker stop cloudkiss || true
                    docker rm cloudkiss || true
                    docker run -d --name cloudkiss -p 8000:8000 ${DOCKER_IMAGE}
                    EOF
                '''
            }
        }
    }
}
