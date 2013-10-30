varnish:
  pkg:
    - installed
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /etc/varnish/default.vcl

varnish-config:
  file.managed:
    - name: /etc/varnish/default.vcl
    - source: salt://varnishd/tfj-redirect.vcl
    - require:
      - pkg: varnish

varnish-geoip:
  file.managed:
    - name: /etc/varnish/geoip.vcl
    - source: salt://varnishd/geoip.vcl
    - require:
      - pkg: varnish

geoip-dir:
  cmd.run:
    - name: sudo mkdir -p /usr/share/GeoIP

geoip-data:
  file.managed:
    - name: /usr/share/GeoIP/GeoIPCity.dat
    - source: salt://data/GeoIPCity.dat
    - require:
      - cmd: geoip-dir
