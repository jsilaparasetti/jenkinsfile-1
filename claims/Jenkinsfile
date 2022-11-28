pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('valaxy-dockerhub')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/ramakant987/Claims_Nov_28.git'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t ramakant987/Claims_Nov_28:latest .'

            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
      //  stage('push image') {
        //    steps{
               
          //      sh 'docker push valaxy/nodeapp:$BUILD_NUMBER'
            //}
        //}
}
post {
        always {
            sh 'docker logout'
        }
    }
}