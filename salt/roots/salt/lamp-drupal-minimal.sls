{% if grains['os'] == 'Ubuntu' %}

php5-pkgs:
  pkg.installed:
    - names:
      - php5
      - php5-curl
      - php5-cli
      - php5-dev
      - php-pear
      - php5-memcache
      - php5-mcrypt
  file.managed:
    - name: /etc/php5/apache2/php.ini
    - source: salt://php5/apache2/php.ini
    - require:
      - pkg: php5-pkgs

php5-cli-config:
  file.managed: 
    - name: /etc/php5/cli/php.ini
    - source: salt://php5/cli/php.ini
    - require:
      - pkg: php5-pkgs

pear-drush:
  cmd.run:
    - name: sudo pear config-set auto_discover 1 > /dev/null
    - require:
      - pkg: php5-pkgs
      - pkg: curl

pear-misc:
  cmd.run:
    - name: /bin/sh /srv/salt/php5/pear-install.sh > /dev/null
    - require:
      - pkg: php5-pkgs

php-composer:
  cmd.run:
    - name: /usr/bin/curl -sS https://getcomposer.org/installer | php
    - require:
      - pkg: php5-pkgs
      - pkg: curl

php-composer-build:
  cmd.run:
    - name: cd /vagrant/www ; /usr/bin/php composer.phar update ; /usr/bin/php composer.phar install
    - require:
      - cmd: php-composer

apache2-env:
  file.managed:
    - name: /etc/apache2/envvars
    - source: salt://apache2/envvars

apache2:
  pkg:
    - installed
    - require:
      - file: apache2-env
  file.managed:
    - name: /etc/apache2/ports.conf
    - source: salt://apache2/ports.conf
    - require:
      - pkg: apache2

apache2-vhosts:
  file.managed:
    - name: /etc/apache2/sites-available/default
    - source: salt://apache2/vhost.conf
    - require:
      - pkg: apache2

apache2-conf:
  file.managed:
    - name: /etc/apache2/apache2.conf
    - source: salt://apache2/apache2.conf
    - require:
      - file: apache2-vhosts

apache2-mods:
  cmd.run:
    - name: sudo a2enmod rewrite
    - require:
      - file: apache2-conf
      - pkg: php5-pkgs

apache2-restart:
  cmd.run:
    - name: sudo chown -R vagrant:vagrant /var/log/apache2 ; sudo chown -R vagrant:vagrant /var/lock/apache2 ; sudo service apache2 restart
    - require:
      - cmd: apache2-mods  

libapache2-mod-php5:
  pkg:
    - installed
    - require:
      - pkg: apache2

{% endif %}
