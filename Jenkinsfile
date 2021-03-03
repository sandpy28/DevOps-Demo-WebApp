pipeline {
  environment {
    imagename = "sandpy28/ubuntu"
    registryCredential = credentials('docker')
    dockerImage = ''
    NEW_VERSION = '1.3.0'
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/sandpy28/DevOps-Demo-WebApp', branch: 'master'])

      }
    }
//stage('SonarQube Analysis') {
//	steps {
//sh "/var/lib/jenkins/tools/hudson.tasks.Maven_MavenInstallation/Maven3.6.3/bin/mvn -Dsonar.test.exclusions=**/test/java/servlet/createpage_junit.java -Dsonar.login=admin -Dsonar.password=sonar -Dsonar.tests=. -Dsonar.inclusions=**/test/java/servlet/createpage_junit.java -Dsonar.sources=. sonar:sonar -Dsonar.host.url=http://142.47.216.82:9000/"
//	}
//	}
stage('Static Code Analysis') {
           steps{
               withSonarQubeEnv(credentialsId: 'sonar', installationName: 'sonarqube') {
                 sh "${tool("sonarqube")}/bin/sonar-scanner \
                -Dsonar.projectKey=. \
                -Dsonar.sources=. \
                -Dsonar.tests=. \
                -Dsonar.inclusions=**/test/java/servlet/createpage_junit.java \
                -Dsonar.test.exclusions=**/test/java/servlet/createpage_junit.java \
                -Dsonar.login=admin \
                -Dsonar.password=sonar "
                 sh 'mvn validate -f pom.xml'
                }
           }
       }
stage('Publish HTML Report') {
steps{
publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '\\Acceptancetest\\target\\surefire-reports', reportFiles: 'index.html', reportName: 'Sanity Test HTML Report', reportTitles: ''])
	}
}
    stage('Building image') {
      steps{
	echo 'building the application'
	echo "building version ${NEW_VERSION}"
        script { dockerImage = docker.build imagename }
      }
    }
    stage('Deploy Image') {
      steps{
	//echo "deploying with ${registryCredential}"
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')

          }
        }
      }
    }
  }
}
