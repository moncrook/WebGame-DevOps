FROM tomcat:10.1-jdk21-temurin

LABEL org.opencontainers.image.source="https://github.com/moncrook/WebGame-DevOps"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY dist/WebGame.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]