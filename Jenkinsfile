pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Eeirq/CloudKiss.git', branch: 'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t eelysa/cloudkiss .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push eelysa/cloudkiss'
                }
            }
        }
        stage('Deploy Application') {
            steps {
                sh 'docker pull eelysa/cloudkiss:latest'
                sh 'docker run -d -p 8000:8000 --name cloudkiss eelysa/cloudkiss:latest'
            }
        }
    }
}
