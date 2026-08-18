# test/ImpURI/instance_methods_test.rb

require_relative '../test_helper'

describe ImpURI do
  describe 'attribute readers' do
    describe 'a very simple http URI' do
      let(:impuri){ImpURI.new('http://example.com')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must return nil if there is no path' do
        _(impuri.path).must_be_nil
      end

      it 'must return nil if there are no GET request parameters' do
        _(impuri.parameter_string).must_be_nil
        _(impuri.parameters).must_be_nil
      end

      it 'must return false for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal false
        _(impuri.has_credentials?).must_equal false
        _(impuri.has_username_and_password?).must_equal false
        _(impuri.has_user_info?).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return nil if there is no request URI' do
        _(impuri.request_uri).must_be_nil
      end
    end # describe 'a very simple http URI'

    describe 'an http URI with a port number' do
      let(:impuri){ImpURI.new('http://example.com:8080')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must return nil if there is no path' do
        _(impuri.path).must_be_nil
      end

      it 'must parse out the port number' do
        _(impuri.port).must_equal '8080'
        _(impuri.portnumber).must_equal '8080'
        _(impuri.port_number).must_equal '8080'
      end

      it 'must return nil if there are no GET request parameters' do
        _(impuri.parameter_string).must_be_nil
        _(impuri.parameters).must_be_nil
      end

      it 'must return false for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal false
        _(impuri.has_credentials?).must_equal false
        _(impuri.has_username_and_password?).must_equal false
        _(impuri.has_user_info?).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return true for has_port_number?()' do
        _(impuri.has_port_number?).must_equal true
        _(impuri.has_port?).must_equal true
        _(impuri.has_portnumber?).must_equal true
        _(impuri.port_number?).must_equal true
        _(impuri.port?).must_equal true
        _(impuri.portnumber?).must_equal true
      end

      it 'must return nil if there is no request URI' do
        _(impuri.request_uri).must_be_nil
      end
    end # describe 'an http URI with a port number'

    describe 'an http URI with a path' do
      let(:impuri){ImpURI.new('http://example.com/path/to/resource')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must parse out the path' do
        _(impuri.path).must_equal '/path/to/resource'
      end

      it 'must return nil if there are no GET request parameters' do
        _(impuri.parameter_string).must_be_nil
        _(impuri.parameters).must_be_nil
      end

      it 'must return false for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal false
        _(impuri.has_credentials?).must_equal false
        _(impuri.has_username_and_password?).must_equal false
        _(impuri.has_user_info?).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return the request URI' do
        _(impuri.request_uri).must_equal '/path/to/resource'
      end
    end # describe 'an http URI with a path'

    describe 'an http URI with a username' do
      let(:impuri){ImpURI.new('http://user@example.com/')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must parse out the username' do
        _(impuri.username).must_equal 'user'
      end

      it 'must return the userinfo string' do
        _(impuri.userinfo).must_equal 'user'
        _(impuri.credentials).must_equal 'user'
        _(impuri.username_and_password).must_equal 'user'
        _(impuri.user_info).must_equal 'user'
      end

      it 'must return nil if there are no GET request parameters' do
        _(impuri.parameter_string).must_be_nil
        _(impuri.parameters).must_be_nil
      end

      it 'must return true for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal true
        _(impuri.has_credentials?).must_equal true
        _(impuri.has_username_and_password?).must_equal true
        _(impuri.has_user_info?).must_equal true
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return nil if there is no request URI' do
        _(impuri.request_uri).must_be_nil
      end
    end # describe 'an http URI with a username'

    describe 'an http URI with a username and password' do
      let(:impuri){ImpURI.new('http://user:pass@example.com/')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must parse out the username' do
        _(impuri.username).must_equal 'user'
        _(impuri.user).must_equal 'user'
      end

      it 'must parse out the password' do
        _(impuri.password).must_equal 'pass'
        _(impuri.pass).must_equal 'pass'
        _(impuri.passwd).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        _(impuri.userinfo).must_equal 'user:pass'
        _(impuri.credentials).must_equal 'user:pass'
        _(impuri.username_and_password).must_equal 'user:pass'
        _(impuri.user_info).must_equal 'user:pass'
      end

      it 'must return nil if there are no GET request parameters' do
        _(impuri.parameter_string).must_be_nil
        _(impuri.parameters).must_be_nil
      end

      it 'must return true for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal true
        _(impuri.has_credentials?).must_equal true
        _(impuri.has_username_and_password?).must_equal true
        _(impuri.has_user_info?).must_equal true
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return nil if there is no request URI' do
        _(impuri.request_uri).must_be_nil
      end
    end # describe 'an http URI with a username and password'

    describe 'an http URI with one GET query parameter' do
      let(:impuri){ImpURI.new('http://example.com/?q=param')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        _(impuri.parameter_string).must_equal 'q=param'
      end

      it 'must parse out the parameter as a hash' do
        _(impuri.parameters).must_equal({'q' => 'param'})
      end

      it 'must return false for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal false
        _(impuri.has_credentials?).must_equal false
        _(impuri.has_username_and_password?).must_equal false
        _(impuri.has_user_info?).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return the request URI' do
        _(impuri.request_uri).must_equal '/?q=param'
      end
    end # describe 'an http URI with one GET query parameter'

    describe 'an http URI with two GET query parameters' do
      let(:impuri){ImpURI.new('http://example.com/?q=param1&r=param2')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        _(impuri.parameter_string).must_equal 'q=param1&r=param2'
      end

      it 'must parse out the parameter as a hash' do
        _(impuri.parameters).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return false for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal false
        _(impuri.has_credentials?).must_equal false
        _(impuri.has_username_and_password?).must_equal false
        _(impuri.has_user_info?).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return the request URI' do
        _(impuri.request_uri).must_equal '/?q=param1&r=param2'
      end
    end # describe 'an http URI with two GET query parameters'

    describe 'an http URI with two GET query parameters separated by a semicolon' do
      let(:impuri){ImpURI.new('http://example.com/?q=param1;r=param2')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        _(impuri.parameter_string).must_equal 'q=param1;r=param2'
      end

      it 'must parse out the parameter as a hash' do
        _(impuri.parameters).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return false for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal false
        _(impuri.has_credentials?).must_equal false
        _(impuri.has_username_and_password?).must_equal false
        _(impuri.has_user_info?).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return the request URI' do
        _(impuri.request_uri).must_equal '/?q=param1;r=param2'
      end
    end # describe 'an http URI with two GET query parameters separated by a semicolon'

    describe 'an http URI with the lot' do
      let(:impuri){ImpURI.new('http://user:pass@example.com:8080/path/to/resource?q=param1&r=param2')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must parse out the path' do
        _(impuri.path).must_equal '/path/to/resource'
      end

      it 'must parse out the port number' do
        _(impuri.port).must_equal '8080'
        _(impuri.port_number).must_equal '8080'
        _(impuri.port_number).must_equal '8080'
      end

      it 'must parse out the username' do
        _(impuri.username).must_equal 'user'
        _(impuri.user).must_equal 'user'
      end

      it 'must parse out the password' do
        _(impuri.password).must_equal 'pass'
        _(impuri.pass).must_equal 'pass'
        _(impuri.passwd).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        _(impuri.userinfo).must_equal 'user:pass'
        _(impuri.credentials).must_equal 'user:pass'
        _(impuri.username_and_password).must_equal 'user:pass'
        _(impuri.user_info).must_equal 'user:pass'
      end

      it 'must parse out the paramter string' do
        _(impuri.parameter_string).must_equal 'q=param1&r=param2'
      end

      it 'must parse out the parameter as a hash' do
        _(impuri.parameters).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return true for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal true
        _(impuri.has_credentials?).must_equal true
        _(impuri.has_username_and_password?).must_equal true
        _(impuri.has_user_info?).must_equal true
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return true for has_port_number?()' do
        _(impuri.has_port_number?).must_equal true
        _(impuri.has_port?).must_equal true
        _(impuri.has_portnumber?).must_equal true
        _(impuri.port_number?).must_equal true
        _(impuri.port?).must_equal true
        _(impuri.portnumber?).must_equal true
      end

      it 'must return the request URI' do
        _(impuri.request_uri).must_equal '/path/to/resource?q=param1&r=param2'
      end
    end # describe 'an http URI with the lot'

    describe 'an http URI with the lot and a semicolon path separator' do
      let(:impuri){ImpURI.new('http://user:pass@example.com:8080/path/to/resource?q=param1;r=param2')}

      it 'must parse out the scheme' do
        _(impuri.scheme).must_equal 'http'
        _(impuri.protocol).must_equal 'http'
        _(impuri.scheme_name).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(impuri.hostname).must_equal 'example.com'
        _(impuri.host).must_equal 'example.com'
      end

      it 'must parse out the path' do
        _(impuri.path).must_equal '/path/to/resource'
      end

      it 'must parse out the port number' do
        _(impuri.port).must_equal '8080'
        _(impuri.port_number).must_equal '8080'
        _(impuri.port_number).must_equal '8080'
      end

      it 'must parse out the username' do
        _(impuri.username).must_equal 'user'
        _(impuri.user).must_equal 'user'
      end

      it 'must parse out the password' do
        _(impuri.password).must_equal 'pass'
        _(impuri.pass).must_equal 'pass'
        _(impuri.passwd).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        _(impuri.userinfo).must_equal 'user:pass'
        _(impuri.credentials).must_equal 'user:pass'
        _(impuri.username_and_password).must_equal 'user:pass'
        _(impuri.user_info).must_equal 'user:pass'
      end

      it 'must parse out the paramter string' do
        _(impuri.parameter_string).must_equal 'q=param1;r=param2'
      end

      it 'must parse out the parameter as a hash' do
        _(impuri.parameters).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return true for has_userinfo?()' do
        _(impuri.has_userinfo?).must_equal true
        _(impuri.has_credentials?).must_equal true
        _(impuri.has_username_and_password?).must_equal true
        _(impuri.has_user_info?).must_equal true
      end

      it 'must return true for has_scheme?()' do
        _(impuri.has_scheme?).must_equal true
        _(impuri.has_protocol?).must_equal true
        _(impuri.has_scheme_name?).must_equal true
        _(impuri.scheme?).must_equal true
        _(impuri.protocol?).must_equal true
        _(impuri.scheme_name?).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(impuri.has_colon_path_separator?).must_equal false
        _(impuri.uses_colon_path_separator?).must_equal false
      end

      it 'must return true for has_port_number?()' do
        _(impuri.has_port_number?).must_equal true
        _(impuri.has_port?).must_equal true
        _(impuri.has_portnumber?).must_equal true
        _(impuri.port_number?).must_equal true
        _(impuri.port?).must_equal true
        _(impuri.portnumber?).must_equal true
      end

      it 'must return the request URI' do
        _(impuri.request_uri).must_equal '/path/to/resource?q=param1;r=param2'
      end
    end # describe 'an http URI with the lot and a semicolon path separator'

    describe 'an ssh identifier' do
      let(:impuri){ImpURI.new('username@example.com:~account')}

      it 'must return a username' do
        _(impuri.username).must_equal 'username'
      end

      it 'must return true for is_ssh?()' do
        _(impuri.is_ssh?).must_equal true
      end

      it 'must correctly determine if it has user info' do
        _(impuri.credentials?).must_equal false
        _(impuri.username_and_password?).must_equal false
        _(impuri.user_info?).must_equal false
        _(impuri.userinfo?).must_equal false
        _(impuri.has_credentials?).must_equal false
        _(impuri.has_username_and_password?).must_equal false
        _(impuri.has_user_info?).must_equal false
        _(impuri.has_userinfo?).must_equal false
      end

      it 'must correctly determine if it has a colon path separator' do
        _(impuri.colon_path_separator?).must_equal true
        _(impuri.has_colon_path_separator?).must_equal true
        _(impuri.uses_colon_path_separator?).must_equal true
      end

      it 'must correctly determine if it has a scheme' do
        _(impuri.protocol?).must_equal false
        _(impuri.scheme_name?).must_equal false
        _(impuri.scheme?).must_equal false
        _(impuri.has_protocol?).must_equal false
        _(impuri.has_scheme_name?).must_equal false
        _(impuri.has_scheme?).must_equal false
      end

      it 'must correctly determine if it has a port number' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return hostname_and_path when requested' do
        _(impuri.hostname_and_path).must_equal 'example.com:~account'
      end

      it 'must return hostname_and_port_number when requested' do
        _(impuri.hostname_and_port_number).must_equal 'example.com'
      end

      it 'must return a hostname' do
        _(impuri.hostname).must_equal 'example.com'
      end

      it 'must return a path' do
        _(impuri.path).must_equal '~account'
      end
    end # describe 'an ssh identifier'

    describe 'an ssh identifier as per Github' do
      let(:impuri){ImpURI.new('git@github.com:thoran/ImpURI.git')}

      it 'must return a username' do
        _(impuri.username).must_equal 'git'
      end

      it 'must return true for is_ssh?()' do
        _(impuri.is_ssh?).must_equal true
      end

      it 'must correctly determine if it has user info' do
        _(impuri.credentials?).must_equal false
        _(impuri.username_and_password?).must_equal false
        _(impuri.user_info?).must_equal false
        _(impuri.userinfo?).must_equal false
        _(impuri.has_credentials?).must_equal false
        _(impuri.has_username_and_password?).must_equal false
        _(impuri.has_user_info?).must_equal false
        _(impuri.has_userinfo?).must_equal false
      end

      it 'must correctly determine if it has a colon path separator' do
        _(impuri.colon_path_separator?).must_equal true
        _(impuri.has_colon_path_separator?).must_equal true
        _(impuri.uses_colon_path_separator?).must_equal true
      end

      it 'must correctly determine if it has a scheme' do
        _(impuri.protocol?).must_equal false
        _(impuri.scheme_name?).must_equal false
        _(impuri.scheme?).must_equal false
        _(impuri.has_protocol?).must_equal false
        _(impuri.has_scheme_name?).must_equal false
        _(impuri.has_scheme?).must_equal false
      end

      it 'must correctly determine if it has a port number' do
        _(impuri.has_port_number?).must_equal false
        _(impuri.has_port?).must_equal false
        _(impuri.has_portnumber?).must_equal false
        _(impuri.port_number?).must_equal false
        _(impuri.port?).must_equal false
        _(impuri.portnumber?).must_equal false
      end

      it 'must return hostname_and_path when requested' do
        _(impuri.hostname_and_path).must_equal 'github.com:thoran/ImpURI.git'
      end

      it 'must return hostname_and_port_number when requested' do
        _(impuri.hostname_and_port_number).must_equal 'github.com'
      end

      it 'must return a hostname' do
        _(impuri.hostname).must_equal 'github.com'
      end

      it 'must return a path' do
        _(impuri.path).must_equal 'thoran/ImpURI.git'
      end
    end # describe 'an ssh identifier as per Github'
  end # describe 'attribute readers'

  describe 'attribute writers' do
    describe 'a very simple http URI' do
      let(:impuri){ImpURI.new('http://example.com')}

      it 'must assign the scheme' do
        impuri.scheme = 'ftp'
        _(impuri.scheme).must_equal 'ftp'
      end

      it 'must assign the username' do
        impuri.username = 'user'
        _(impuri.username).must_equal 'user'
      end

      it 'must assign the password' do
        impuri.password = 'pass'
        _(impuri.password).must_equal 'pass'
      end

      it 'must assign the hostname' do
        impuri.hostname = 'example2.com'
        _(impuri.hostname).must_equal 'example2.com'
      end

      it 'must assign the port number' do
        impuri.port_number = '8080'
        _(impuri.port_number).must_equal '8080'
      end

      it 'must assign the path' do
        impuri.path = '/path/to/here'
        _(impuri.path).must_equal '/path/to/here'
      end

      it 'must assign the parameter string' do
        impuri.path = '/'
        impuri.parameter_string = 'a=1&b=2'
        _(impuri.parameter_string).must_equal 'a=1&b=2'
      end

      it 'must assign the parameter string and cause the parameters to be assigned also' do
        impuri.path = '/'
        impuri.parameter_string = 'a=1&b=2'
        _(impuri.parameters).must_equal({'a' => '1', 'b' => '2'})
      end

      it 'must assign the parameters and cause the parameter_sting to be assigned also' do
        impuri.path = '/'
        impuri.parameters = {'a' => '1', 'b' => '2'}
        _(impuri.parameter_string).must_equal 'a=1&b=2'
      end

      it 'must return true for has_userinfo?() after setting username and password' do
        impuri.username = 'user'
        impuri.password = 'pass'
        _(impuri.has_userinfo?).must_equal true
      end

      it 'must return true for has_port_number?() after setting the port number' do
        impuri.port_number = '8080'
        _(impuri.has_port_number?).must_equal true
      end

      it 'must return a URI string with all attributes which have been set' do
        impuri.scheme = 'ftp'
        impuri.username = 'user'
        impuri.password = 'pass'
        impuri.hostname = 'example2.com'
        impuri.port_number = '8080'
        impuri.path = '/path/to/here'
        impuri.parameter_string = 'a=1&b=2'
        _(impuri.to_s).must_equal 'ftp://user:pass@example2.com:8080/path/to/here?a=1&b=2'
      end
    end # describe 'a very simple http URI'
  end # describe 'attribute writers'

  describe '#to_ssh' do
    describe 'a URI-style identifier' do
      let(:impuri){ImpURI.new('github.com/thoran/lineage')}

      # The slash stood between the hostname and the path rather than anchoring
      # the path, and after a colon it would say the path began at the root.
      it 'must not carry the separating slash into the path' do
        _(impuri.to_ssh).must_equal 'github.com:thoran/lineage'
      end
    end # describe 'a URI-style identifier'

    describe 'a URI-style identifier with a scheme' do
      let(:impuri){ImpURI.new('https://github.com/thoran/lineage')}

      it 'must leave the scheme out, there being no place for one' do
        _(impuri.to_ssh).must_equal 'github.com:thoran/lineage'
      end
    end # describe 'a URI-style identifier with a scheme'

    describe 'an ssh identifier with a path from the login directory' do
      let(:impuri){ImpURI.new('git@github.com:thoran/lineage.git')}

      it 'must return what it was given' do
        _(impuri.to_ssh).must_equal 'git@github.com:thoran/lineage.git'
      end
    end # describe 'an ssh identifier with a path from the login directory'

    describe 'an ssh identifier with a path from the root' do
      let(:impuri){ImpURI.new('user@host.com:/srv/git/thing.git')}

      it 'must keep the leading slash, that being the whole of the difference' do
        _(impuri.to_ssh).must_equal 'user@host.com:/srv/git/thing.git'
      end
    end # describe 'an ssh identifier with a path from the root'

    describe 'an identifier with a password' do
      let(:impuri){ImpURI.new('user:pass@host.com:/srv/git/thing.git')}

      it 'must render the username alone, ssh having no use for a password here' do
        _(impuri.to_ssh).must_equal 'user@host.com:/srv/git/thing.git'
      end
    end # describe 'an identifier with a password'

    describe 'an identifier with a port number' do
      let(:impuri){ImpURI.new('http://example.com:8080/a/b')}

      it 'must drop the port number, this form having nowhere to put one' do
        _(impuri.to_ssh).must_equal 'example.com:a/b'
      end
    end # describe 'an identifier with a port number'

    describe 'an identifier with no path' do
      let(:impuri){ImpURI.new('example.com')}

      it 'must return the hostname and a colon, being the login directory' do
        _(impuri.to_ssh).must_equal 'example.com:'
      end
    end # describe 'an identifier with no path'
  end # describe '#to_ssh'

  describe '#username_with_separator' do
    it 'must return the username and an at sign where there is one' do
      _(ImpURI.new('git@github.com:thoran/lineage.git').username_with_separator).must_equal 'git@'
    end

    it 'must return an empty string where there is none' do
      _(ImpURI.new('github.com/thoran/lineage').username_with_separator).must_equal ''
    end
  end # describe '#username_with_separator'
end
