# recipe-manager
## Webapp to manage recipe library.

# Installation Notes
1. This application uses Java 8 so if you don't have that installed get it from [Java 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
2. Install latest version of [Maven](https://maven.apache.org/download.cgi)
3. Install [Tomcat 8](https://tomcat.apache.org/download-80.cgi)
4. Install [MySQL](http://dev.mysql.com/downloads/mysql/), the latest is 5.7.11 which is fine.

# Running
1. Execute `mvn clean package`
2. Copy the generated war file in the target directory, to your tomcat distribution's webapps directory as ROOT.war
```
cp target/recipe-manager-0.0.1-SNAPSHOT.war /usr/local/apache-tomcat-8.0.32/webapps/ROOT.war
```