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

### Rendering

```ruby
impuri.to_s
# => the string it was given back again

ImpURI.new('github.com/thoran/lineage').to_ssh
# => 'github.com:thoran/lineage'

ImpURI.new('git@github.com:thoran/lineage.git').to_ssh
# => 'git@github.com:thoran/lineage.git'

ImpURI.new('user@host.com:/srv/git/thing.git').to_ssh
# => 'user@host.com:/srv/git/thing.git'
```

`#to_ssh` renders the same resource as an ssh/scp descriptor, `[username@]hostname:path`.

Where the path arrived after a colon it is left as it stands, since a leading slash there is the difference between a path from the root and one from the login directory, and an ssh descriptor is returned unchanged.  Where the path arrived after a slash, that slash separated it from the hostname rather than anchoring it, and so is not carried into a form where it would say the other thing.

A scheme, a port number and a password are all dropped, this form having no place for any of them.

## Contributing

1. Fork it ( https://github.com/thoran/impuri/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
