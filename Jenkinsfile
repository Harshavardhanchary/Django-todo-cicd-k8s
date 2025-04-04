pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                git credentialsId: 'git-cred',
                    url: 'https://github.com/Harshavardhanchary/Django-todo-cicd-k8s.git',
                    branch: 'main'
            }
        }

        stage('Build Docker') {
            steps {
                script {
                    echo 'Building Docker Image'
                    sh "docker build -t harshavardhan303/cicd-e2e:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push the Artifacts') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        echo 'Logging into Docker Hub'
                        sh """
                            echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                            echo 'Pushing Docker Image to Docker Hub'
                            docker push harshavardhan303/cicd-e2e:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

        stage('Checkout K8S Manifest SCM') {
            steps {
                git credentialsId: 'git-cred',
                    url: 'https://github.com/Harshavardhanchary/k8s-manifests-repo.git',
                    branch: 'main'
            }
        }

        stage('Update K8S Manifest & Push to Repo') {
            steps {
                script {
                    // Use GitHub credentials securely to push updated manifest
                    withCredentials([usernamePassword(credentialsId: 'git-cred', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        echo 'Current deploy.yaml content:'
                        sh 'cat deploy.yaml'

                        // Replace build number in the deploy.yaml dynamically
                        echo "Updating deploy.yaml with build number ${BUILD_NUMBER}"
                        sh """
                            sed -i 's/image-latest/${BUILD_NUMBER}/g' deploy.yaml
                        """

                        echo 'Updated deploy.yaml content:'
                        sh 'cat deploy.yaml'

                        // Git commit and push changes
                        sh """
                            git add deploy.yaml
                            git commit -m "Updated deploy.yaml with build number ${BUILD_NUMBER} | Jenkins Pipeline"
                            git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/Harshavardhanchary/k8s-manifests-repo.git
                            git push origin HEAD:main
                        """
                    }
                }
            }
        }
    }
}

