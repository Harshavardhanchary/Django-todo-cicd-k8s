pipeline {
    agent any

    environment {
        // Define environment variables if necessary (e.g., database URLs, secret keys)
        DJANGO_SECRET_KEY = 'your_django_secret_key'
        DATABASE_URL = 'your_database_url'
    }

    tools {
        python 'Python 3.8' // Specify Python version (make sure Jenkins has Python installed)
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the latest code from the repository
                checkout scm
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                script {
                    // Set up the virtual environment
                    sh 'python3 -m venv venv'
                    sh './venv/bin/pip install --upgrade pip'
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install project dependencies (from requirements.txt)
                sh './venv/bin/pip install -r requirements.txt'
            }
        }


        stage('Build Docker Image') {
            steps {
                script {
                    // Build a Docker image for the application (if using Docker)
                    sh 'docker build -t django-todo-app .'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy your app to the desired environment (e.g., AWS, Heroku, etc.)
                    // Example: using SSH or Kubernetes
                    sh '''
                    ssh user@yourserver "cd /path/to/your/app && git pull && docker-compose up -d"
                    '''
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace or perform post actions like notifications
            cleanWs()
        }

        success {
            // Actions to take on successful build (e.g., notify success)
            echo "Build and deployment successful!"
        }

        failure {
            // Actions to take on failed build (e.g., notify failure)
            echo "Build or deployment failed!"
        }
    }
}
