pipeline { 
    agent any 
    environment { 
        DOCKER_REPO = 'rishabhs2004/mentorbaba-quiz' 
    } 
    stages { 
        stage('Test') { 
            steps { 
                echo 'Mentorbaba Quiz App Testing...' 
            } 
        } 
        stage('Build Docker') { 
            steps { 
                script { 
                    def image = docker.build("${DOCKER_REPO}:${BUILD_NUMBER}") 
                } 
            } 
        } 
    } 
} 
