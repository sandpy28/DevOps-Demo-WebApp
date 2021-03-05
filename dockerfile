from tomcat:latest
RUN wget https://raw.githubusercontent.com/devopsbc01/Scripts/master/Postgresql-Install-1.sh
RUN bash Postgresql-Install-1.sh
RUN mkdir /usr/local/tomcat/webapps/mywebapp
COPY target/AVNCommunication-1.0.war /usr/local/tomcat/webapps/QAWebapp.war
