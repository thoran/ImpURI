# test/ImpURI/class_methods.rb

gem 'minitest'

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib')))

require 'ImpURI'
require 'minitest/autorun'

describe ImpURI do
  describe 'ImpURI class methods' do

    describe 'parse()' do
      it 'must return an object of class ImpURI' do
        ImpURI.parse('http://example.com').class.must_equal ImpURI
      end
    end

    describe 'a very simple http URI' do
      before do
        @http_uri = 'http://example.com'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must return nil if there is no path' do
        ImpURI.path(@http_uri).must_equal nil
      end

      it 'must return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end

      it 'must return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
        ImpURI.userinfo?(@http_uri).must_equal false
        ImpURI.credentials?(@http_uri).must_equal false
        ImpURI.username_and_password?(@http_uri).must_equal false
        ImpURI.user_info?(@http_uri).must_equal false
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
        ImpURI.has_portnumber?(@http_uri).must_equal false
        ImpURI.port_number?(@http_uri).must_equal false
        ImpURI.port?(@http_uri).must_equal false
        ImpURI.portnumber?(@http_uri).must_equal false
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return nil if there is no request URI' do
        ImpURI.request_uri(@http_uri).must_equal nil
      end
    end # describe 'a very simple http URI'

    describe 'an http URI with a port number' do
      before do
        @http_uri = 'http://example.com:8080'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must return nil if there is no path' do
        ImpURI.path(@http_uri).must_equal nil
      end

      it 'must parse out the port number' do
        ImpURI.port(@http_uri).must_equal '8080'
        ImpURI.portnumber(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
      end

      it 'must return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end

      it 'must return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
        ImpURI.userinfo?(@http_uri).must_equal false
        ImpURI.credentials?(@http_uri).must_equal false
        ImpURI.username_and_password?(@http_uri).must_equal false
        ImpURI.user_info?(@http_uri).must_equal false
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return true for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal true
        ImpURI.has_port?(@http_uri).must_equal true
        ImpURI.has_portnumber?(@http_uri).must_equal true
        ImpURI.port_number?(@http_uri).must_equal true
        ImpURI.port?(@http_uri).must_equal true
        ImpURI.portnumber?(@http_uri).must_equal true
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return nil if there is no request URI' do
        ImpURI.request_uri(@http_uri).must_equal nil
      end
    end # describe 'an http URI with a port number'

    describe 'an http URI with a path' do
      before do
        @http_uri = 'http://example.com/path/to/resource'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must parse out the path' do
        ImpURI.path(@http_uri).must_equal '/path/to/resource'
      end

      it 'must return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end

      it 'must return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
        ImpURI.userinfo?(@http_uri).must_equal false
        ImpURI.credentials?(@http_uri).must_equal false
        ImpURI.username_and_password?(@http_uri).must_equal false
        ImpURI.user_info?(@http_uri).must_equal false
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
        ImpURI.has_portnumber?(@http_uri).must_equal false
        ImpURI.port_number?(@http_uri).must_equal false
        ImpURI.port?(@http_uri).must_equal false
        ImpURI.portnumber?(@http_uri).must_equal false
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/path/to/resource'
      end
    end # describe 'an http URI with a path'

    describe 'an http URI with a username' do
      before do
        @http_uri = 'http://user@example.com/'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must parse out the username' do
        ImpURI.username(@http_uri).must_equal 'user'
      end

      it 'must return the userinfo string' do
        ImpURI.userinfo(@http_uri).must_equal 'user'
        ImpURI.credentials(@http_uri).must_equal 'user'
        ImpURI.username_and_password(@http_uri).must_equal 'user'
        ImpURI.user_info(@http_uri).must_equal 'user'
      end

      it 'must return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end

      it 'must return true for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal true
        ImpURI.has_credentials?(@http_uri).must_equal true
        ImpURI.has_username_and_password?(@http_uri).must_equal true
        ImpURI.has_user_info?(@http_uri).must_equal true
        ImpURI.userinfo?(@http_uri).must_equal true
        ImpURI.credentials?(@http_uri).must_equal true
        ImpURI.username_and_password?(@http_uri).must_equal true
        ImpURI.user_info?(@http_uri).must_equal true
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
        ImpURI.has_portnumber?(@http_uri).must_equal false
        ImpURI.port_number?(@http_uri).must_equal false
        ImpURI.port?(@http_uri).must_equal false
        ImpURI.portnumber?(@http_uri).must_equal false
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return nil if there is no request URI' do
        ImpURI.request_uri(@http_uri).must_equal nil
      end
    end # describe 'an http URI with a username'

    describe 'an http URI with a username and password' do
      before do
        @http_uri = 'http://user:pass@example.com/'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must parse out the username' do
        ImpURI.username(@http_uri).must_equal 'user'
        ImpURI.user(@http_uri).must_equal 'user'
      end

      it 'must parse out the password' do
        ImpURI.password(@http_uri).must_equal 'pass'
        ImpURI.pass(@http_uri).must_equal 'pass'
        ImpURI.passwd(@http_uri).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        ImpURI.userinfo(@http_uri).must_equal 'user:pass'
        ImpURI.credentials(@http_uri).must_equal 'user:pass'
        ImpURI.username_and_password(@http_uri).must_equal 'user:pass'
        ImpURI.user_info(@http_uri).must_equal 'user:pass'
      end

      it 'must return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end

      it 'must return true for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal true
        ImpURI.has_credentials?(@http_uri).must_equal true
        ImpURI.has_username_and_password?(@http_uri).must_equal true
        ImpURI.has_user_info?(@http_uri).must_equal true
        ImpURI.userinfo?(@http_uri).must_equal true
        ImpURI.credentials?(@http_uri).must_equal true
        ImpURI.username_and_password?(@http_uri).must_equal true
        ImpURI.user_info?(@http_uri).must_equal true
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
        ImpURI.has_portnumber?(@http_uri).must_equal false
        ImpURI.port_number?(@http_uri).must_equal false
        ImpURI.port?(@http_uri).must_equal false
        ImpURI.portnumber?(@http_uri).must_equal false
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return nil if there is no request URI' do
        ImpURI.request_uri(@http_uri).must_equal nil
      end
    end # describe 'an http URI with a username and password'

    describe 'an http URI with one GET query parameter' do
      before do
        @http_uri = 'http://example.com/?q=param'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param'
      end

      it 'must parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param'})
      end

      it 'must return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
        ImpURI.userinfo?(@http_uri).must_equal false
        ImpURI.credentials?(@http_uri).must_equal false
        ImpURI.username_and_password?(@http_uri).must_equal false
        ImpURI.user_info?(@http_uri).must_equal false
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
        ImpURI.has_portnumber?(@http_uri).must_equal false
        ImpURI.port_number?(@http_uri).must_equal false
        ImpURI.port?(@http_uri).must_equal false
        ImpURI.portnumber?(@http_uri).must_equal false
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/?q=param'
      end
    end # describe 'an http URI with one GET query parameter'

    describe 'an http URI with two GET query parameters' do
      before do
        @http_uri = 'http://example.com/?q=param1&r=param2'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param1&r=param2'
      end

      it 'must parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
        ImpURI.userinfo?(@http_uri).must_equal false
        ImpURI.credentials?(@http_uri).must_equal false
        ImpURI.username_and_password?(@http_uri).must_equal false
        ImpURI.user_info?(@http_uri).must_equal false
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
        ImpURI.has_portnumber?(@http_uri).must_equal false
        ImpURI.port_number?(@http_uri).must_equal false
        ImpURI.port?(@http_uri).must_equal false
        ImpURI.portnumber?(@http_uri).must_equal false
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/?q=param1&r=param2'
      end
    end # describe 'an http URI with two GET query parameters'

    describe 'an http URI with two GET query parameters separated by a semicolon' do
      before do
        @http_uri = 'http://example.com/?q=param1;r=param2'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param1;r=param2'
      end

      it 'must parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
        ImpURI.userinfo?(@http_uri).must_equal false
        ImpURI.credentials?(@http_uri).must_equal false
        ImpURI.username_and_password?(@http_uri).must_equal false
        ImpURI.user_info?(@http_uri).must_equal false
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
        ImpURI.has_portnumber?(@http_uri).must_equal false
        ImpURI.port_number?(@http_uri).must_equal false
        ImpURI.port?(@http_uri).must_equal false
        ImpURI.portnumber?(@http_uri).must_equal false
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/?q=param1;r=param2'
      end
    end # describe 'an http URI with two GET query parameters separated by a semicolon'

    describe 'an http URI with the lot' do
      before do
        @http_uri = 'http://user:pass@example.com:8080/path/to/resource?q=param1&r=param2'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must parse out the path' do
        ImpURI.path(@http_uri).must_equal '/path/to/resource'
      end

      it 'must parse out the port number' do
        ImpURI.port(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
      end

      it 'must parse out the username' do
        ImpURI.username(@http_uri).must_equal 'user'
        ImpURI.user(@http_uri).must_equal 'user'
      end

      it 'must parse out the password' do
        ImpURI.password(@http_uri).must_equal 'pass'
        ImpURI.pass(@http_uri).must_equal 'pass'
        ImpURI.passwd(@http_uri).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        ImpURI.userinfo(@http_uri).must_equal 'user:pass'
        ImpURI.credentials(@http_uri).must_equal 'user:pass'
        ImpURI.username_and_password(@http_uri).must_equal 'user:pass'
        ImpURI.user_info(@http_uri).must_equal 'user:pass'
      end

      it 'must parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param1&r=param2'
      end

      it 'must parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return true for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal true
        ImpURI.has_credentials?(@http_uri).must_equal true
        ImpURI.has_username_and_password?(@http_uri).must_equal true
        ImpURI.has_user_info?(@http_uri).must_equal true
        ImpURI.userinfo?(@http_uri).must_equal true
        ImpURI.credentials?(@http_uri).must_equal true
        ImpURI.username_and_password?(@http_uri).must_equal true
        ImpURI.user_info?(@http_uri).must_equal true
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return true for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal true
        ImpURI.has_port?(@http_uri).must_equal true
        ImpURI.has_portnumber?(@http_uri).must_equal true
        ImpURI.port_number?(@http_uri).must_equal true
        ImpURI.port?(@http_uri).must_equal true
        ImpURI.portnumber?(@http_uri).must_equal true
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/path/to/resource?q=param1&r=param2'
      end
    end # describe 'an http URI with the lot'

    describe 'an http URI with the lot and a semicolon path separator' do
      before do
        @http_uri = 'http://user:pass@example.com:8080/path/to/resource?q=param1;r=param2'
      end

      it 'must parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end

      it 'must parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end

      it 'must parse out the path' do
        ImpURI.path(@http_uri).must_equal '/path/to/resource'
      end

      it 'must parse out the port number' do
        ImpURI.port(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
      end

      it 'must parse out the username' do
        ImpURI.username(@http_uri).must_equal 'user'
        ImpURI.user(@http_uri).must_equal 'user'
      end

      it 'must parse out the password' do
        ImpURI.password(@http_uri).must_equal 'pass'
        ImpURI.pass(@http_uri).must_equal 'pass'
        ImpURI.passwd(@http_uri).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        ImpURI.userinfo(@http_uri).must_equal 'user:pass'
        ImpURI.credentials(@http_uri).must_equal 'user:pass'
        ImpURI.username_and_password(@http_uri).must_equal 'user:pass'
        ImpURI.user_info(@http_uri).must_equal 'user:pass'
      end

      it 'must parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param1;r=param2'
      end

      it 'must parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return true for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal true
        ImpURI.has_credentials?(@http_uri).must_equal true
        ImpURI.has_username_and_password?(@http_uri).must_equal true
        ImpURI.has_user_info?(@http_uri).must_equal true
        ImpURI.userinfo?(@http_uri).must_equal true
        ImpURI.credentials?(@http_uri).must_equal true
        ImpURI.username_and_password?(@http_uri).must_equal true
        ImpURI.user_info?(@http_uri).must_equal true
      end

      it 'must return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
        ImpURI.scheme?(@http_uri).must_equal true
        ImpURI.protocol?(@http_uri).must_equal true
        ImpURI.scheme_name?(@http_uri).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        ImpURI.colon_path_separator?(@http_uri).must_equal false
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end

      it 'must return true for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal true
        ImpURI.has_port?(@http_uri).must_equal true
        ImpURI.has_portnumber?(@http_uri).must_equal true
        ImpURI.port_number?(@http_uri).must_equal true
        ImpURI.port?(@http_uri).must_equal true
        ImpURI.portnumber?(@http_uri).must_equal true
      end

      it 'must return false for is_ssh?()' do
        ImpURI.is_ssh?(@http_uri).must_equal false
      end

      it 'must return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/path/to/resource?q=param1;r=param2'
      end
    end # describe 'an http URI with the lot and a semicolon path separator'

    describe 'an ssh identifier' do
      before do
        @ssh_identifier = 'username@example.com:~account'
      end

      it 'must return a username' do
        ImpURI.username(@ssh_identifier).must_equal 'username'
      end

      it 'must correctly determine if it has user info' do
        ImpURI.credentials?(@ssh_identifier).must_equal false
        ImpURI.username_and_password?(@ssh_identifier).must_equal false
        ImpURI.user_info?(@ssh_identifier).must_equal false
        ImpURI.userinfo?(@ssh_identifier).must_equal false
        ImpURI.has_credentials?(@ssh_identifier).must_equal false
        ImpURI.has_username_and_password?(@ssh_identifier).must_equal false
        ImpURI.has_user_info?(@ssh_identifier).must_equal false
        ImpURI.has_userinfo?(@ssh_identifier).must_equal false
      end

      it 'must correctly determine if it has a scheme' do
        ImpURI.has_scheme?(@ssh_identifier).must_equal false
        ImpURI.has_protocol?(@ssh_identifier).must_equal false
        ImpURI.has_scheme_name?(@ssh_identifier).must_equal false
        ImpURI.scheme?(@ssh_identifier).must_equal false
        ImpURI.protocol?(@ssh_identifier).must_equal false
        ImpURI.scheme_name?(@ssh_identifier).must_equal false
      end

      it 'must correctly determine if it has a colon path separator' do
        ImpURI.colon_path_separator?(@ssh_identifier).must_equal true
        ImpURI.has_colon_path_separator?(@ssh_identifier).must_equal true
        ImpURI.uses_colon_path_separator?(@ssh_identifier).must_equal true
      end

      it 'must correctly determine if it has a port number' do
        ImpURI.has_port_number?(@ssh_identifier).must_equal false
        ImpURI.has_port?(@ssh_identifier).must_equal false
        ImpURI.has_portnumber?(@ssh_identifier).must_equal false
        ImpURI.port_number?(@ssh_identifier).must_equal false
        ImpURI.port?(@ssh_identifier).must_equal false
        ImpURI.portnumber?(@ssh_identifier).must_equal false
      end

      it 'must return true for is_ssh?()' do
        ImpURI.is_ssh?(@ssh_identifier).must_equal true
      end

      it 'must return hostname_and_path when requested' do
        ImpURI.hostname_and_path(@ssh_identifier).must_equal 'example.com:~account'
      end

      it 'must return hostname_and_port_number when requested' do
        ImpURI.hostname_and_port_number(@ssh_identifier).must_equal 'example.com'
      end

      it 'must return a hostname' do
        ImpURI.hostname(@ssh_identifier).must_equal 'example.com'
      end

      it 'must return a path' do
        ImpURI.path(@ssh_identifier).must_equal '~account'
      end
    end # describe 'an ssh identifier'

    describe 'an ssh identifier as per Github' do
      before do
        @ssh_identifier = 'git@github.com:thoran/ImpURI.git'
      end

      it 'must return a username' do
        ImpURI.username(@ssh_identifier).must_equal 'git'
      end

      it 'must correctly determine if it has user info' do
        ImpURI.credentials?(@ssh_identifier).must_equal false
        ImpURI.username_and_password?(@ssh_identifier).must_equal false
        ImpURI.user_info?(@ssh_identifier).must_equal false
        ImpURI.userinfo?(@ssh_identifier).must_equal false
        ImpURI.has_credentials?(@ssh_identifier).must_equal false
        ImpURI.has_username_and_password?(@ssh_identifier).must_equal false
        ImpURI.has_user_info?(@ssh_identifier).must_equal false
        ImpURI.has_userinfo?(@ssh_identifier).must_equal false
      end

      it 'must correctly determine if it has a scheme' do
        ImpURI.has_scheme?(@ssh_identifier).must_equal false
        ImpURI.has_protocol?(@ssh_identifier).must_equal false
        ImpURI.has_scheme_name?(@ssh_identifier).must_equal false
        ImpURI.scheme?(@ssh_identifier).must_equal false
        ImpURI.protocol?(@ssh_identifier).must_equal false
        ImpURI.scheme_name?(@ssh_identifier).must_equal false
      end

      it 'must correctly determine if it has a colon path separator' do
        ImpURI.colon_path_separator?(@ssh_identifier).must_equal true
        ImpURI.has_colon_path_separator?(@ssh_identifier).must_equal true
        ImpURI.uses_colon_path_separator?(@ssh_identifier).must_equal true
      end

      it 'must correctly determine if it has a port number' do
        ImpURI.has_port_number?(@ssh_identifier).must_equal false
        ImpURI.has_port?(@ssh_identifier).must_equal false
        ImpURI.has_portnumber?(@ssh_identifier).must_equal false
        ImpURI.port_number?(@ssh_identifier).must_equal false
        ImpURI.port?(@ssh_identifier).must_equal false
        ImpURI.portnumber?(@ssh_identifier).must_equal false
      end

      it 'must return true for is_ssh?()' do
        ImpURI.is_ssh?(@ssh_identifier).must_equal true
      end

      it 'must return hostname_and_path when requested' do
        ImpURI.hostname_and_path(@ssh_identifier).must_equal 'github.com:thoran/ImpURI.git'
      end

      it 'must return hostname_and_port_number when requested' do
        ImpURI.hostname_and_port_number(@ssh_identifier).must_equal 'github.com'
      end

      it 'must return a hostname' do
        ImpURI.hostname(@ssh_identifier).must_equal 'github.com'
      end

      it 'must return a path' do
        ImpURI.path(@ssh_identifier).must_equal 'thoran/ImpURI.git'
      end
    end # describe 'an ssh identifier as per Github'

  end
end
