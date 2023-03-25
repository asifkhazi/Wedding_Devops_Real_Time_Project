FROM ubuntu:latest
LABEL "auther"="asifkhazi248@gmail.com"
LABEL "Project_Name"="Wedding_website."
RUN apt-get install apache2 -y
RUN apt-get install unzip -y
ADD https://www.tooplate.com/zip-templates/2131_wedding_lite.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip 2131_wedding_lite.zip
RUN cp -rvf 2131_wedding_lite/* .
RUN rm -rf 2131_wedding_lite.zip 2131_wedding_lite
CMD ["user/sbin/apache2ctl","-D","FOREGROUND"]
EXPOSE 80