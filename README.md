# varnish-client

varnish-client is a HTTP client of Varnish.

# Install

Add the following line to Gemfile.

    gem 'varnish-client', :git => 'https://github.com/mono0x/varnish-client.git'

Install the gem.

    $ bundle install

Download purge.vcl.

    $ sudo wget https://raw.github.com/mono0x/varnish-client/master/purge.vcl

Add the following line to the main VCL file.

    include "/path/to/purge.vcl";

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

