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
                echo 'Building Node.js application Docker image...'
                sh 'docker build -t nodejs-app:latest .'
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo 'Deploying Node.js + MySQL using Docker Compose...'
                sh 'docker compose down || true'
                sh 'docker compose up -d --build'
            }
        }

        stage('Health Check') {
            steps {
                echo 'Performing health check...'
                // Wait for app to start
                sh 'sleep 10'
                // Check health endpoint (if defined)
                sh 'curl -fsS http://localhost:3000 || echo "Health check failed"'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully!'
        }
        failure {
            echo '❌ Build failed! Check console logs for details.'
        }
    }
}
