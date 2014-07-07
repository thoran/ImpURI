# test/ImpURI/instance_methods.rb

gem 'minitest'

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib')))

require 'ImpURI'
require 'minitest/autorun'

describe ImpURI do

  describe 'attribute readers' do

    describe 'a very simple http URI' do

      before do
        @impuri = ImpURI.new('http://example.com')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must return nil if there is no path' do
        @impuri.path.must_equal nil
      end

      it 'must return nil if there are no GET request parameters' do
        @impuri.parameter_string.must_equal nil
        @impuri.parameters.must_equal nil
      end

      it 'must return false for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return false for has_port_number?()' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return nil if there is no request URI' do
        @impuri.request_uri.must_equal nil
      end
    end # describe 'a very simple http URI'

    describe 'an http URI with a port number' do
      before do
        @impuri = ImpURI.new('http://example.com:8080')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must return nil if there is no path' do
        @impuri.path.must_equal nil
      end

      it 'must parse out the port number' do
        @impuri.port.must_equal '8080'
        @impuri.portnumber.must_equal '8080'
        @impuri.port_number.must_equal '8080'
      end

      it 'must return nil if there are no GET request parameters' do
        @impuri.parameter_string.must_equal nil
        @impuri.parameters.must_equal nil
      end

      it 'must return false for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return true for has_port_number?()' do
        @impuri.has_port_number?.must_equal true
        @impuri.has_port?.must_equal true
        @impuri.has_portnumber?.must_equal true
        @impuri.port_number?.must_equal true
        @impuri.port?.must_equal true
        @impuri.portnumber?.must_equal true
      end

      it 'must return nil if there is no request URI' do
        @impuri.request_uri.must_equal nil
      end
    end # describe 'an http URI with a port number'

    describe 'an http URI with a path' do
      before do
        @impuri = ImpURI.new('http://example.com/path/to/resource')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must parse out the path' do
        @impuri.path.must_equal '/path/to/resource'
      end

      it 'must return nil if there are no GET request parameters' do
        @impuri.parameter_string.must_equal nil
        @impuri.parameters.must_equal nil
      end

      it 'must return false for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return false for has_port_number?()' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return the request URI' do
        @impuri.request_uri.must_equal '/path/to/resource'
      end
    end # describe 'an http URI with a path'

    describe 'an http URI with a username' do
      before do
        @impuri = ImpURI.new('http://user@example.com/')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must parse out the username' do
        @impuri.username.must_equal 'user'
      end

      it 'must return the userinfo string' do
        @impuri.userinfo.must_equal 'user'
        @impuri.credentials.must_equal 'user'
        @impuri.username_and_password.must_equal 'user'
        @impuri.user_info.must_equal 'user'
      end

      it 'must return nil if there are no GET request parameters' do
        @impuri.parameter_string.must_equal nil
        @impuri.parameters.must_equal nil
      end

      it 'must return true for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal true
        @impuri.has_credentials?.must_equal true
        @impuri.has_username_and_password?.must_equal true
        @impuri.has_user_info?.must_equal true
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return false for has_port_number?()' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return nil if there is no request URI' do
        @impuri.request_uri.must_equal nil
      end
    end # describe 'an http URI with a username'

    describe 'an http URI with a username and password' do
      before do
        @impuri = ImpURI.new('http://user:pass@example.com/')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must parse out the username' do
        @impuri.username.must_equal 'user'
        @impuri.user.must_equal 'user'
      end

      it 'must parse out the password' do
        @impuri.password.must_equal 'pass'
        @impuri.pass.must_equal 'pass'
        @impuri.passwd.must_equal 'pass'
      end

      it 'must return the userinfo string' do
        @impuri.userinfo.must_equal 'user:pass'
        @impuri.credentials.must_equal 'user:pass'
        @impuri.username_and_password.must_equal 'user:pass'
        @impuri.user_info.must_equal 'user:pass'
      end

      it 'must return nil if there are no GET request parameters' do
        @impuri.parameter_string.must_equal nil
        @impuri.parameters.must_equal nil
      end

      it 'must return true for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal true
        @impuri.has_credentials?.must_equal true
        @impuri.has_username_and_password?.must_equal true
        @impuri.has_user_info?.must_equal true
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return false for has_port_number?()' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return nil if there is no request URI' do
        @impuri.request_uri.must_equal nil
      end
    end # describe 'an http URI with a username and password'

    describe 'an http URI with one GET query parameter' do
      before do
        @impuri = ImpURI.new('http://example.com/?q=param')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        @impuri.parameter_string.must_equal 'q=param'
      end

      it 'must parse out the parameter as a hash' do
        @impuri.parameters.must_equal({'q' => 'param'})
      end

      it 'must return false for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return false for has_port_number?()' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return the request URI' do
        @impuri.request_uri.must_equal '/?q=param'
      end
    end # describe 'an http URI with one GET query parameter'

    describe 'an http URI with two GET query parameters' do
      before do
        @impuri = ImpURI.new('http://example.com/?q=param1&r=param2')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        @impuri.parameter_string.must_equal 'q=param1&r=param2'
      end

      it 'must parse out the parameter as a hash' do
        @impuri.parameters.must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return false for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return false for has_port_number?()' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return the request URI' do
        @impuri.request_uri.must_equal '/?q=param1&r=param2'
      end
    end # describe 'an http URI with two GET query parameters'

    describe 'an http URI with two GET query parameters separated by a semicolon' do
      before do
        @impuri = ImpURI.new('http://example.com/?q=param1;r=param2')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        @impuri.parameter_string.must_equal 'q=param1;r=param2'
      end

      it 'must parse out the parameter as a hash' do
        @impuri.parameters.must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return false for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return false for has_port_number?()' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return the request URI' do
        @impuri.request_uri.must_equal '/?q=param1;r=param2'
      end
    end # describe 'an http URI with two GET query parameters separated by a semicolon'

    describe 'an http URI with the lot' do
      before do
        @impuri = ImpURI.new('http://user:pass@example.com:8080/path/to/resource?q=param1&r=param2')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must parse out the path' do
        @impuri.path.must_equal '/path/to/resource'
      end

      it 'must parse out the port number' do
        @impuri.port.must_equal '8080'
        @impuri.port_number.must_equal '8080'
        @impuri.port_number.must_equal '8080'
      end

      it 'must parse out the username' do
        @impuri.username.must_equal 'user'
        @impuri.user.must_equal 'user'
      end

      it 'must parse out the password' do
        @impuri.password.must_equal 'pass'
        @impuri.pass.must_equal 'pass'
        @impuri.passwd.must_equal 'pass'
      end

      it 'must return the userinfo string' do
        @impuri.userinfo.must_equal 'user:pass'
        @impuri.credentials.must_equal 'user:pass'
        @impuri.username_and_password.must_equal 'user:pass'
        @impuri.user_info.must_equal 'user:pass'
      end

      it 'must parse out the paramter string' do
        @impuri.parameter_string.must_equal 'q=param1&r=param2'
      end

      it 'must parse out the parameter as a hash' do
        @impuri.parameters.must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return true for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal true
        @impuri.has_credentials?.must_equal true
        @impuri.has_username_and_password?.must_equal true
        @impuri.has_user_info?.must_equal true
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return true for has_port_number?()' do
        @impuri.has_port_number?.must_equal true
        @impuri.has_port?.must_equal true
        @impuri.has_portnumber?.must_equal true
        @impuri.port_number?.must_equal true
        @impuri.port?.must_equal true
        @impuri.portnumber?.must_equal true
      end

      it 'must return the request URI' do
        @impuri.request_uri.must_equal '/path/to/resource?q=param1&r=param2'
      end
    end # describe 'an http URI with the lot'

    describe 'an http URI with the lot and a semicolon path separator' do
      before do
        @impuri = ImpURI.new('http://user:pass@example.com:8080/path/to/resource?q=param1;r=param2')
      end

      it 'must parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end

      it 'must parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end

      it 'must parse out the path' do
        @impuri.path.must_equal '/path/to/resource'
      end

      it 'must parse out the port number' do
        @impuri.port.must_equal '8080'
        @impuri.port_number.must_equal '8080'
        @impuri.port_number.must_equal '8080'
      end

      it 'must parse out the username' do
        @impuri.username.must_equal 'user'
        @impuri.user.must_equal 'user'
      end

      it 'must parse out the password' do
        @impuri.password.must_equal 'pass'
        @impuri.pass.must_equal 'pass'
        @impuri.passwd.must_equal 'pass'
      end

      it 'must return the userinfo string' do
        @impuri.userinfo.must_equal 'user:pass'
        @impuri.credentials.must_equal 'user:pass'
        @impuri.username_and_password.must_equal 'user:pass'
        @impuri.user_info.must_equal 'user:pass'
      end

      it 'must parse out the paramter string' do
        @impuri.parameter_string.must_equal 'q=param1;r=param2'
      end

      it 'must parse out the parameter as a hash' do
        @impuri.parameters.must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return true for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal true
        @impuri.has_credentials?.must_equal true
        @impuri.has_username_and_password?.must_equal true
        @impuri.has_user_info?.must_equal true
      end

      it 'must return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
        @impuri.scheme?.must_equal true
        @impuri.protocol?.must_equal true
        @impuri.scheme_name?.must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end

      it 'must return true for has_port_number?()' do
        @impuri.has_port_number?.must_equal true
        @impuri.has_port?.must_equal true
        @impuri.has_portnumber?.must_equal true
        @impuri.port_number?.must_equal true
        @impuri.port?.must_equal true
        @impuri.portnumber?.must_equal true
      end

      it 'must return the request URI' do
        @impuri.request_uri.must_equal '/path/to/resource?q=param1;r=param2'
      end
    end # describe 'an http URI with the lot and a semicolon path separator'

    describe 'an ssh identifier' do
      before do
        @impuri = ImpURI.new('username@example.com:~account')
      end

      it 'must return a username' do
        @impuri.username.must_equal 'username'
      end

      it 'must return true for is_ssh?()' do
        @impuri.is_ssh?.must_equal true
      end

      it 'must correctly determine if it has user info' do
        @impuri.credentials?.must_equal false
        @impuri.username_and_password?.must_equal false
        @impuri.user_info?.must_equal false
        @impuri.userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
        @impuri.has_userinfo?.must_equal false
      end

      it 'must correctly determine if it has a colon path separator' do
        @impuri.colon_path_separator?.must_equal true
        @impuri.has_colon_path_separator?.must_equal true
        @impuri.uses_colon_path_separator?.must_equal true
      end

      it 'must correctly determine if it has a scheme' do
        @impuri.protocol?.must_equal false
        @impuri.scheme_name?.must_equal false
        @impuri.scheme?.must_equal false
        @impuri.has_protocol?.must_equal false
        @impuri.has_scheme_name?.must_equal false
        @impuri.has_scheme?.must_equal false
      end

      it 'must correctly determine if it has a port number' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return hostname_and_path when requested' do
        @impuri.hostname_and_path.must_equal 'example.com:~account'
      end

      it 'must return hostname_and_port_number when requested' do
        @impuri.hostname_and_port_number.must_equal 'example.com'
      end

      it 'must return a hostname' do
        @impuri.hostname.must_equal 'example.com'
      end

      it 'must return a path' do
        @impuri.path.must_equal '~account'
      end
    end # describe 'an ssh identifier'

    describe 'an ssh identifier as per Github' do
      before do
        @impuri = ImpURI.new('git@github.com:thoran/ImpURI.git')
      end

      it 'must return a username' do
        @impuri.username.must_equal 'git'
      end

      it 'must return true for is_ssh?()' do
        @impuri.is_ssh?.must_equal true
      end

      it 'must correctly determine if it has user info' do
        @impuri.credentials?.must_equal false
        @impuri.username_and_password?.must_equal false
        @impuri.user_info?.must_equal false
        @impuri.userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
        @impuri.has_userinfo?.must_equal false
      end

      it 'must correctly determine if it has a colon path separator' do
        @impuri.colon_path_separator?.must_equal true
        @impuri.has_colon_path_separator?.must_equal true
        @impuri.uses_colon_path_separator?.must_equal true
      end

      it 'must correctly determine if it has a scheme' do
        @impuri.protocol?.must_equal false
        @impuri.scheme_name?.must_equal false
        @impuri.scheme?.must_equal false
        @impuri.has_protocol?.must_equal false
        @impuri.has_scheme_name?.must_equal false
        @impuri.has_scheme?.must_equal false
      end

      it 'must correctly determine if it has a port number' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
        @impuri.has_portnumber?.must_equal false
        @impuri.port_number?.must_equal false
        @impuri.port?.must_equal false
        @impuri.portnumber?.must_equal false
      end

      it 'must return hostname_and_path when requested' do
        @impuri.hostname_and_path.must_equal 'github.com:thoran/ImpURI.git'
      end

      it 'must return hostname_and_port_number when requested' do
        @impuri.hostname_and_port_number.must_equal 'github.com'
      end

      it 'must return a hostname' do
        @impuri.hostname.must_equal 'github.com'
      end

      it 'must return a path' do
        @impuri.path.must_equal 'thoran/ImpURI.git'
      end
    end # describe 'an ssh identifier as per Github'

  end # describe 'attribute readers'

  describe 'attribute writers' do

    describe 'a very simple http URI' do
      before do
        @impuri = ImpURI.new('http://example.com')
      end

      it 'must assign the scheme' do
        @impuri.scheme = 'ftp'
        @impuri.scheme.must_equal 'ftp'
      end

      it 'must assign the username' do
        @impuri.username = 'user'
        @impuri.username.must_equal 'user'
      end

      it 'must assign the password' do
        @impuri.password = 'pass'
        @impuri.password.must_equal 'pass'
      end

      it 'must assign the hostname' do
        @impuri.hostname = 'example2.com'
        @impuri.hostname.must_equal 'example2.com'
      end

      it 'must assign the port number' do
        @impuri.port_number = '8080'
        @impuri.port_number.must_equal '8080'
      end

      it 'must assign the path' do
        @impuri.path = '/path/to/here'
        @impuri.path.must_equal '/path/to/here'
      end

      it 'must assign the parameter string' do
        @impuri.path = '/'
        @impuri.parameter_string = 'a=1&b=2'
        @impuri.parameter_string.must_equal 'a=1&b=2'
      end

      it 'must assign the parameter string and cause the parameters to be assigned also' do
        @impuri.path = '/'
        @impuri.parameter_string = 'a=1&b=2'
        @impuri.parameters.must_equal({'a' => '1', 'b' => '2'})
      end

      it 'must assign the parameters and cause the parameter_sting to be assigned also' do
        @impuri.path = '/'
        @impuri.parameters = {'a' => '1', 'b' => '2'}
        @impuri.parameter_string.must_equal 'a=1&b=2'
      end

      it 'must return true for has_userinfo?() after setting username and password' do
        @impuri.username = 'user'
        @impuri.password = 'pass'
        @impuri.has_userinfo?.must_equal true
      end

      it 'must return true for has_port_number?() after setting the port number' do
        @impuri.port_number = '8080'
        @impuri.has_port_number?.must_equal true
      end

      it 'must return a URI string with all attributes which have been set' do
        @impuri.scheme = 'ftp'
        @impuri.username = 'user'
        @impuri.password = 'pass'
        @impuri.hostname = 'example2.com'
        @impuri.port_number = '8080'
        @impuri.path = '/path/to/here'
        @impuri.parameter_string = 'a=1&b=2'
        @impuri.to_s.must_equal 'ftp://user:pass@example2.com:8080/path/to/here?a=1&b=2'
      end
    end # describe 'a very simple http URI'

  end # describe 'attribute writers'

end
