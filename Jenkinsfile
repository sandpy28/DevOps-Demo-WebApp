pipeline {
  agent any
  stages {
stage('usernamePassword') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: ‘tomcat, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
  // available as an env variable, but will be masked if you try to print it out any which way
  // note: single quotes prevent Groovy interpolation; expansion is by Bourne Shell, which is what you want
  //sh 'echo $PASSWORD'
  // also available as a Groovy variable
  echo USERNAME
  // or inside double quotes for string interpolation
  echo "username is $USERNAME"
          }
        }
      }
    }
}
}