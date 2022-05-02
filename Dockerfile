FROM php:8.1.4-fpm-bullseye

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer

RUN set -eux; \
	echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | tee /etc/apt/sources.list.d/symfony-cli.list \
	 && apt-get update; \
	apt-get install -y --no-install-recommends \
	symfony-cli \
    git \
    nano

WORKDIR /var/www/project_name_dir
RUN git config --global user.email "email@test.git" && git config --global user.name "username"

RUN docker-php-ext-install pdo mysqli opcache pdo_mysql
RUN pecl install xdebug && docker-php-ext-enable xdebug

EXPOSE 9000
EXPOSE 8000
