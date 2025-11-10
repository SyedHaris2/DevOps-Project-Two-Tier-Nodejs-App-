pipeline {
  agent any
  environment {
    DOCKER_BUILDKIT = '1'
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build Image') {
      steps {
        sh 'docker build -t node-app:latest .'
      }
    }
    stage('Docker Compose Deploy') {
      steps {
        sh 'docker compose down || true'
        sh 'docker compose up -d --build'
      }
    }
    stage('Post-deploy Healthcheck') {
      steps {
        sh 'sleep 10'
        sh 'curl -fsS http://localhost:3000/health'
      }
    }
  }
  post {
    failure {
      echo 'Build failed — check console output'
    }
    success {
      echo 'Deployed successfully'
    }
  }
}
