pipeline {
    
    agent any 
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                git credentialsId: 'git-cred', 
                url: 'https://github.com/Harshavardhanchary/Django-todo-cicd-k8s.git',
                branch: 'main'
           }
        }

        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Buid Docker Image'
                    docker build -t harshavardhan303/cicd-e2e:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh '''
                        echo 'Login to Docker Hub'
                        docker login -u harshavardhan303 -p Chary@357
                        echo 'Push to Repo'
                        docker push harshavardhan303/cicd-e2e:${BUILD_NUMBER}
                        '''
                    }
                }
            }
        }
        
        stage('Checkout K8S manifest SCM'){
            steps {
                git credentialsId: 'git-cred', 
                url: 'https://github.com/Harshavardhanchary/k8s-manifests-repo.git',
                branch: 'main'
            }
        }
        stage('Update K8S manifest & push to Repo') {
            steps {
                script {
                    // Use GitHub credentials securely to push updated manifest
                    withCredentials([usernamePassword(credentialsId: 'git-cred', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        echo 'Current deploy.yaml content:'
                        cat deploy.yaml

                        # Replace 32 with the build number dynamically
                        sed -i "s/32/${BUILD_NUMBER}/g" deploy.yaml

                        echo 'Updated deploy.yaml content:'
                        cat deploy.yaml

                        # Git commit and push
                        git add deploy.yaml
                        git commit -m "Updated the deploy yaml with build number ${BUILD_NUMBER} | Jenkins Pipeline"
                        git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/Harshavardhanchary/k8s-manifests-repo.git
                        git push origin HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}
