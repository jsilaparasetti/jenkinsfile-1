node{
   
    stage("Git Clone"){

        git branch: 'main', url: 'https://github.com/jsilaparasetti/jenkinsfile-1.git'
    }
   
    stage("Docker build"){
        sh 'docker version'
        sh 'cd claims-api && docker build -t ineeladri/app-2-img:latest -f Dockerfile .'
        sh 'docker image ls'
    }

    withCredentials([string(credentialsId: 'ineeladri', variable: 'PASSWORD')]) {
        sh 'docker login -u ineeladri -p $PASSWORD'
    }

    stage("Pushing Image to Docker Hub"){
     
       sh 'docker push ineeladri/app-2-img:latest'
    
    } 
}
