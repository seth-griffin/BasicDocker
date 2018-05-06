# LAMP
#
# VERSION               1.0.0

FROM  ubuntu:16.04
LABEL Description="This image is used to serve as a very basic lamp environment." \
        Vendor="griffinseth" \
        Version="1.0" \
        Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 -p [HOST DB PORT NUMBER]:3306 -v [HOST WWW DOCUMENT ROOT]:/var/www/html -v [HOST DB DOCUMENT ROOT]:/var/lib/mysql "

ENV MYSQL_PWD sesame42
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
                    apache2 \
                    libapache2-mod-php7.0 \
                    mysql-server-5.7 \ 
                    mysql-client-5.7 \
                    php7.0 \
                    php7.0-bz2 \
                    php7.0-cgi \
                    php7.0-cli \
                    php7.0-common \
                    php7.0-curl \
                    php7.0-dev \
                    php7.0-enchant \
                    php7.0-fpm \
                    php7.0-gd \
                    php7.0-gmp \
                    php7.0-imap \
                    php7.0-interbase \
                    php7.0-intl \
                    php7.0-json \
                    php7.0-ldap \
                    php7.0-mbstring \
                    php7.0-mcrypt \
                    php7.0-mysql \
                    php7.0-odbc \
                    php7.0-opcache \
                    php7.0-pgsql \
                    php7.0-phpdbg \
                    php7.0-pspell \
                    php7.0-readline \
                    php7.0-recode \
                    php7.0-snmp \
                    php7.0-sqlite3 \
                    php7.0-sybase \
                    php7.0-tidy \
                    php7.0-xmlrpc \
                    php7.0-xsl \
                    php7.0-zip \
                    composer \
                    tree \
                    zip \
                    git \
                    vim \
                    curl

COPY files/etc/apache2/sites-available/lamp-node.conf /etc/apache2/sites-available/lamp-node.conf

RUN a2enmod rewrite ssl
RUN chown -R www-data:www-data /var/www/html

COPY files/entrypoint.sh /usr/src/

RUN ["chmod", "+x", "/usr/src/entrypoint.sh"]

RUN a2ensite lamp-node
RUN service apache2 restart

VOLUME /var/www/html
VOLUME /var/log/apache2
VOLUME /var/lib/mysql
VOLUME /var/log/mysql

EXPOSE 80
EXPOSE 3306

ENTRYPOINT ["/usr/src/entrypoint.sh"]
