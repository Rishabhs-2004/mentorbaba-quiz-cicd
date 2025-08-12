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
        stage('Deploy to EC2') {
    steps {
        sshagent(['ec2-ssh-key']) {
            sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@<EC2_PUBLIC_IP> "
                docker pull ${DOCKER_REPO}:latest &&
                docker stop quiz-container || true &&
                docker rm quiz-container || true &&
                docker run -d --name quiz-container -p 80:5000 ${DOCKER_REPO}:latest
            "
            '''
        }
    }
}

    } 
} 
