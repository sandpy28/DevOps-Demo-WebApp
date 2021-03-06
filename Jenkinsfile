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
stage('Build') {
           steps {
              sh 'mvn compile -f pom.xml'
           }
       }
stage('Deploy to test') {
           steps {
               sh 'mvn package -f pom.xml'
               deploy adapters: [tomcat8(credentialsId: 'tomcat', path: '', url: 'http://3.142.120.106:8080/')], contextPath: '/QAWebapp', onFailure: false, war: '**/*.war'
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
stage('Docker Build and Tag') {
           steps {
                sh 'docker build -t webapp:latest .'
                sh 'docker tag webapp sandpy28/webapp:latest'
          }
        }
stage('Publish image to Docker Hub') {
            steps {
        withDockerRegistry([ credentialsId: "docker", url: "" ]) {
          sh  'docker push sandpy28/webapp:latest'
        		}         
        	}
        }
stage('Run Docker container on remote hosts') {         
            steps {
                sh "docker -H ssh://root@45.62.251.60 run -d -p 8081:8080 sandpy28/webapp:latest"
            }
        }
	  /*
	  stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$BUILD_NUMBER"
         sh "docker rmi $imagename:latest"
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
            //dockerImage.push("$BUILD_NUMBER")
            dockerImage.push('latest')
          }
        }
      }
    }*/
	  
  }
}
