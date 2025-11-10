pipeline {
    agent any
    environment {
        DOCKER_BUILDKIT = '1'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/SyedHaris2/DevOps-Project-Two-Tier-Nodejs-App-.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Node.js Docker image...'
                sh 'docker build -t nodejs-app:latest .'
            }
        }
        stage('Deploy with Docker Compose') {
            steps {
                echo 'Stopping old containers if any...'
                sh 'docker compose down || true'
                echo 'Starting Node.js + MySQL stack...'
                sh 'docker compose up -d --build'
            }
        }
        stage('Wait for Services') {
            steps {
                echo 'Waiting for MySQL and Node app to be healthy...'
                sh 'sleep 20'
            }
        }
        stage('Health Check') {
            steps {
                echo 'Checking Node app health...'
                sh 'curl -fsS http://localhost:3000/health || exit 1'
            }
        }
    }
    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Build failed!'
        }
    }
}
