pipeline {
  environment {
    imagename = "sandpy28/ubuntu"
    registryCredential = credentials(‘docker’)
    dockerImage = ''
    NEW_VERSION = "1.3.0"
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/sandpy28/DevOps-Demo-WebApp', branch: 'master'])

      }
    }
    stage('Building image') {
      steps{
	      echo ‘building the application’
	      echo “building version ${NEW_VERSION}”
        script { dockerImage = docker.build imagename }
      }
    }
    stage('Deploy Image') {
      steps{
	       echo “deploying with ${registryCredential}”
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')

          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$BUILD_NUMBER"
         sh "docker rmi $imagename:latest"
      }
    }
  }
}
