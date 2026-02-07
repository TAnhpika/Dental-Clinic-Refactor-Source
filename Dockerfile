# Dockerfile cho ứng dụng Dental Clinic
FROM tomcat:10.0-jdk11-openjdk

# Cài đặt MySQL client
RUN apt-get update && apt-get install -y mysql-client

# Copy file WAR vào Tomcat
COPY dist/TestFull.war /usr/local/tomcat/webapps/ROOT.war

# Copy thư mục lib vào WEB-INF
COPY library_Assignment/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# Copy file cấu hình database
COPY vinahost_connection_config.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"] 