# Rack::Host

Rack middleware to 404 requests that aren't to a whitelisted hostname.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-host'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-host

## Usage

in a Rack app...

```ruby
require 'rack/host'
use Rack::Host, hosts: ['myhostname.com']
```

or in a rails app environment file (e.g. config/environments/production.rb)...

```ruby
config.middleware.insert_before Rack::Sendfile, Rack::LockHost, hosts: ['myhostname.com']
```