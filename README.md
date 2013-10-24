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

To test redirects, pass a two-letter country code via GET:

[http://localhost:12122/?country=CA](http://localhost:12122/?country=CA)

To view the redirect result without getting served a 302, add a `debug=1`:

[http://localhost:12122/?country=CA&debug=1](http://localhost:12122/?country=CA&debug=1)

To run (incredibly minimalist) unit tests from within the vagrant instance:

`cd /vagrant/www && phpunit`
