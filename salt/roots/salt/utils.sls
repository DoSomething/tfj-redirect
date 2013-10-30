{% if grains['os'] == 'Ubuntu' %}


apt-update:
  cmd.run:
    - name: sudo apt-get update

curl:
  pkg:
    - installed

sendmail:
  pkg:
    - installed
    
git:
  pkg:
    - installed

vim:
  cmd.run:
    - name: sudo apt-get install vim --yes

bash-fix:
  cmd.run:
    - name: sudo rm /bin/sh && sudo ln -s /bin/bash /bin/sh
  require:
    - pkg: apache2

{% endif %}
