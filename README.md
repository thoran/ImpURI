# ImpURI

## Description

This is a hand-written non-validating parser for URI's and ssh/scp almost URI resource descriptors which is intended to be cleaner and simpler than Ruby's standard URI.  

## Raison d'etre

I wrote it for two reasons... 

1. Ruby's standard URI library doesn't handle ssh/scp resource descriptors, which are the near-to, not quite URI, but commonly used, ssh/scp way of describing a network addressable resource: username:password@host:path.  URI's have a scheme at the start, and the path begins with only a forward slash, whereas an ssh/scp resource has no scheme, and the path begins with a colon and a slash.  I wanted to be able to handle both.  

2. Ruby's standard URI class does too much.  It is overblown and untidy.  I just want it to break the strings down and that's it.  I don't want any scheme interpolation from the port number, nor from the host name, or any other 'smarts'.  

## Installation

Add this line to your application's Gemfile:

	gem 'impuri'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install impuri

## Usage

```ruby
impuri = ImpURI.parse('scheme://user:pass@hostname.domain.name:20/path/to/resource?q=param')
# => an object of class ImpURI

impuri.scheme OR impuri.protocol
# => 'scheme'

impuri.userinfo OR impuri.credentials OR impuri.user_info OR impuri.username_and_password
# => 'user:pass'

impuri.user OR impuri.username
# => 'user'

impuri.pass OR impuri.passwd OR impuri.password
# => 'pass'

impuri.host OR impuri.hostname
# => 'hostname.domain.name'

impuri.port OR impuri.portnumber OR impuri.port_number
# => '20'

impuri.path
# => '/path/to/resource'

impuri.parameter_string
# => 'q=param'

impuri.parameters
# => {'q' => 'param'}
```

## Contributing

1. Fork it ( https://github.com/thoran/ImpURI/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
