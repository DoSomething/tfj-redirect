Teens For Jeans Redirect App
============================

Laravel app for teensforjeans.com.

This wafer-thin app checks the X-Geo-IP header for a "country:XX" code, where XX is a two-letter country code (e.g., US, CA). Each can redirect to an appropriate site.

The header is assumed to come from Varnish.

Installation
============

The Vagrant box is built and configured via Salt. If you don't have Salty Vagrant installed, go here first:

https://github.com/saltstack/salty-vagrant

After you've installed this, cd to the project root and

`vagrant up`

You'll then have two ports reserved for the app:

- 12121: Apache httpd
- 12122: varnishd

Varnish is configured simply to pass all requests on to the app.

Testing
=======

To test redirects at the app level, pass a two-letter country code via GET:

[http://localhost:12121/?country=CA](http://localhost:12121/?country=CA)

To view the redirect result without getting served a 302, add a `debug=1`:

[http://localhost:12121/?country=CA&debug=1](http://localhost:12121/?country=CA&debug=1)

To run (incredibly minimalist) unit tests from within the vagrant instance:

`cd /vagrant/www && phpunit`

To test IP-based redirects in Varnish, simply hit [http://localhost:12122](http://localhost:12122) while running `varnishlog` within Vagrant. You should see the IP match and response in the log.

Implementation Details
======================

The VCL project is courtesy of Opera Software: [https://github.com/cosimo/varnish-geoip](https://github.com/cosimo/varnish-geoip)

We are using this fork, which has some important config changes for Varnish startup and custom C function handling: [https://github.com/montaguethomas/varnish-geoip](https://github.com/montaguethomas/varnish-geoip)

The GeoIP database is from MaxMind: [http://dev.maxmind.com/geoip/legacy/downloadable/](http://dev.maxmind.com/geoip/legacy/downloadable/). We use the [Legacy `GeoIPCity.dat` database](http://dev.maxmind.com/geoip/legacy/downloadable/).

The GeoIP C API needed to be installed to enable the VCL build: [https://github.com/maxmind/geoip-api-c](https://github.com/maxmind/geoip-api-c)

Salt auto-installs the pre-built geoapi.vcl in /etc/varnish/. The GeoIP .dat file needs to live at /usr/share/lib/GeoIP.

Having trouble starting Varnish? See [this discussion of the init.d script](http://stackoverflow.com/questions/5906603/varnish-daemon-opts-options-errors).
