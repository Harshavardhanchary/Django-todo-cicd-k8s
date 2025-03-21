pipeline {
    
    agent any 
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_CREDENTIALS_ID = 'docker' // Update this with your Docker credentials ID
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                git credentialsId: 'harsha', 
                url: 'https://github.com/Harshavardhanchary/Django-todo-cicd-k8s.git',
                branch: 'main'
           }
        }

        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Build Docker Image'
                    docker build -t harshavardhan303/cicd-e2e:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    withCredentials([usernamePassword(credentialsId: "${Docker}", usernameVariable: 'DOCKER_UERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh '''
                        echo 'Logging in to Docker Hub'
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        if [ $? -ne 0 ]; then
                            echo 'Docker login failed'
                            exit 1
                        fi
                        echo 'Push to Repo'
                        docker push harshavardhan303/cicd-e2e:${BUILD_NUMBER}
                        if [ $? -ne 0 ]; then
                            echo 'Docker push failed'
                            exit 1
                        fi
                        '''
                    }
                }
            }
        }
    }
}
