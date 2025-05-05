pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'cloudkiss'
        DOCKER_HUB_REPO = 'eelysa/cloudkiss:latest'
    }
    stages {
        stage('Pull Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Eeirq/CloudKiss.git'
            }
        }
        stage('Docker Login') {
            steps {
               withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
               sh 'echo $DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin'
               }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'docker tag ${DOCKER_IMAGE} ${DOCKER_HUB_REPO}'
                sh 'docker push ${DOCKER_HUB_REPO}'
            }
        }
        stage('Deploy to EC2') {
            steps {
                sh '''
                    ssh -i "CloudStar.pem" ec2-user@${EC2_HOST} <<EOF
                    docker stop cloudkiss || true
                    docker rm cloudkiss || true
                    docker pull ${DOCKER_HUB_REPO}
                    docker run -d --name cloudkiss -p 8000:8000 ${DOCKER_HUB_REPO}
                    EOF
                '''
            }
        }
    }
}
