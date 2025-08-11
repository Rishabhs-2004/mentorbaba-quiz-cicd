pipeline { 
    agent any 
    stages { 
        stage('Checkout') { 
            steps { 
                checkout scm 
            } 
        } 
        stage('Test') { 
            steps { 
                echo 'Mentorbaba Quiz App - CI/CD Pipeline Working!' 
            } 
        } 
        stage('Build') { 
            steps { 
                echo 'Building Mentorbaba Quiz Application...' 
            } 
        } 
    } 
} 
