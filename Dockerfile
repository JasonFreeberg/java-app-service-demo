# Builds an image using the Zulu JRE, which gives you free support and security patches when used on Azure.
FROM mcr.microsoft.com/java/jre-headless:8u212-zulu-alpine
COPY ./target/app.jar /usr/src/

RUN apt-get install --yes --no-install-recommends openssh-server \
     && echo "root:Docker!" | chpasswd 

COPY sshd_config /etc/ssh/

WORKDIR /usr/src
EXPOSE 80 2222
CMD ["/usr/sbin/sshd", "java", "-jar", "app.jar"]