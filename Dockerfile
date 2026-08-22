FROM tomcat:10.1-jdk21

COPY dist/WebGame.war /usr/local/tomcat/webapps/WebGame.war

EXPOSE 8080

CMD ["catalina.sh", "run"]