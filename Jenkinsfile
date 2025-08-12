pipeline { 
    agent any 
    environment { 
        DOCKER_REPO = 'rishabhs2004/mentorbaba-quiz' 
    } 
    stages { 
        stage('Checkout') { 
            steps { 
                checkout scm 
            } 
        } 
        stage('Test') { 
            steps { 
                echo 'Testing Mentorbaba Quiz App...' 
            } 
        } 
        stage('Build Docker Image') { 
            steps { 
                script { 
                    def image = docker.build("${DOCKER_REPO}:${BUILD_NUMBER}") 
                    docker.withRegistry('', 'dockerhub-creds') { 
                        image.push() 
                        image.push('latest') 
                    } 
                } 
            } 
        } 
    } 
} 
