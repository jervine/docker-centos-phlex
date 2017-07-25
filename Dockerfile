# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#RUN yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y supervisor httpd httpd-tools git gettext openssl logrotate 
# commented out php71 php71-php-xmlrpc php71-php-gd
RUN yum update -y
RUN yum clean all

RUN cd /var/www/html; git clone https://github.com/d8ahazard/Phlex

ADD supervisord.conf /etc/supervisord.conf
ADD start.sh /usr/sbin/start.sh
RUN chmod 755 /usr/sbin/start.sh

VOLUME /config

EXPOSE 9012
ENTRYPOINT ["/usr/sbin/start.sh"]
