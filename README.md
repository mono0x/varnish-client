# varnish-client

varnish-client is a HTTP client of Varnish.

# Install

Add the following line to Gemfile.

    gem 'varnish-client', :git => 'https://github.com/mono0x/varnish-client.git'

Install the gem.

    $ bundle install

Add the following subroutine to VCL.

    acl purge {
      "localhost";
    }

    sub vcl_recv {
      if (req.request == "PURGE") {
        if (!client.ip ~ purge) {
          error 405 "Not allowed.";
        }
        ban("req.http.host == " + req.http.host + " && req.url ~ " + req.url);
        error 200 "Purged.";
      }
    }

# Getting started

Here is an example of purge and fetch the cache.

    require 'varnish/client'
    varnish = Varnish::Client.new('localhost', 6081, 'http://example.com')
    # purge
    varnish.purge '^/date/2011/'
    varnish.purge '.*'
    # fetch
    varnish.fetch '/index'
    varnish.fetch '/mobile', 'User-Agent' => 'iPhone'

