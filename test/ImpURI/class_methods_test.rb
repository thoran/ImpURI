# test/ImpURI/class_methods_test.rb

require_relative '../test_helper'

describe ImpURI do
  describe 'ImpURI class methods' do

    describe 'parse()' do
      it 'must return an object of class ImpURI' do
        _(ImpURI.parse('http://example.com').class).must_equal ImpURI
      end
    end

    describe 'a very simple http URI' do
      let(:http_uri){'http://example.com'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must return nil if there is no path' do
        _(ImpURI.path(http_uri)).must_be_nil
      end

      it 'must return nil if there are no GET request parameters' do
        _(ImpURI.parameter_string(http_uri)).must_be_nil
        _(ImpURI.parameters(http_uri)).must_be_nil
      end

      it 'must return false for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal false
        _(ImpURI.has_credentials?(http_uri)).must_equal false
        _(ImpURI.has_username_and_password?(http_uri)).must_equal false
        _(ImpURI.has_user_info?(http_uri)).must_equal false
        _(ImpURI.userinfo?(http_uri)).must_equal false
        _(ImpURI.credentials?(http_uri)).must_equal false
        _(ImpURI.username_and_password?(http_uri)).must_equal false
        _(ImpURI.user_info?(http_uri)).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal false
        _(ImpURI.has_port?(http_uri)).must_equal false
        _(ImpURI.has_portnumber?(http_uri)).must_equal false
        _(ImpURI.port_number?(http_uri)).must_equal false
        _(ImpURI.port?(http_uri)).must_equal false
        _(ImpURI.portnumber?(http_uri)).must_equal false
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return nil if there is no request URI' do
        _(ImpURI.request_uri(http_uri)).must_be_nil
      end
    end # describe 'a very simple http URI'

    describe 'an http URI with a port number' do
      let(:http_uri){'http://example.com:8080'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must return nil if there is no path' do
        _(ImpURI.path(http_uri)).must_be_nil
      end

      it 'must parse out the port number' do
        _(ImpURI.port(http_uri)).must_equal '8080'
        _(ImpURI.portnumber(http_uri)).must_equal '8080'
        _(ImpURI.port_number(http_uri)).must_equal '8080'
      end

      it 'must return nil if there are no GET request parameters' do
        _(ImpURI.parameter_string(http_uri)).must_be_nil
        _(ImpURI.parameters(http_uri)).must_be_nil
      end

      it 'must return false for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal false
        _(ImpURI.has_credentials?(http_uri)).must_equal false
        _(ImpURI.has_username_and_password?(http_uri)).must_equal false
        _(ImpURI.has_user_info?(http_uri)).must_equal false
        _(ImpURI.userinfo?(http_uri)).must_equal false
        _(ImpURI.credentials?(http_uri)).must_equal false
        _(ImpURI.username_and_password?(http_uri)).must_equal false
        _(ImpURI.user_info?(http_uri)).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return true for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal true
        _(ImpURI.has_port?(http_uri)).must_equal true
        _(ImpURI.has_portnumber?(http_uri)).must_equal true
        _(ImpURI.port_number?(http_uri)).must_equal true
        _(ImpURI.port?(http_uri)).must_equal true
        _(ImpURI.portnumber?(http_uri)).must_equal true
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return nil if there is no request URI' do
        _(ImpURI.request_uri(http_uri)).must_be_nil
      end
    end # describe 'an http URI with a port number'

    describe 'an http URI with a path' do
      let(:http_uri){'http://example.com/path/to/resource'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must parse out the path' do
        _(ImpURI.path(http_uri)).must_equal '/path/to/resource'
      end

      it 'must return nil if there are no GET request parameters' do
        _(ImpURI.parameter_string(http_uri)).must_be_nil
        _(ImpURI.parameters(http_uri)).must_be_nil
      end

      it 'must return false for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal false
        _(ImpURI.has_credentials?(http_uri)).must_equal false
        _(ImpURI.has_username_and_password?(http_uri)).must_equal false
        _(ImpURI.has_user_info?(http_uri)).must_equal false
        _(ImpURI.userinfo?(http_uri)).must_equal false
        _(ImpURI.credentials?(http_uri)).must_equal false
        _(ImpURI.username_and_password?(http_uri)).must_equal false
        _(ImpURI.user_info?(http_uri)).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal false
        _(ImpURI.has_port?(http_uri)).must_equal false
        _(ImpURI.has_portnumber?(http_uri)).must_equal false
        _(ImpURI.port_number?(http_uri)).must_equal false
        _(ImpURI.port?(http_uri)).must_equal false
        _(ImpURI.portnumber?(http_uri)).must_equal false
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return the request URI' do
        _(ImpURI.request_uri(http_uri)).must_equal '/path/to/resource'
      end
    end # describe 'an http URI with a path'

    describe 'an http URI with a username' do
      let(:http_uri){'http://user@example.com/'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must parse out the username' do
        _(ImpURI.username(http_uri)).must_equal 'user'
      end

      it 'must return the userinfo string' do
        _(ImpURI.userinfo(http_uri)).must_equal 'user'
        _(ImpURI.credentials(http_uri)).must_equal 'user'
        _(ImpURI.username_and_password(http_uri)).must_equal 'user'
        _(ImpURI.user_info(http_uri)).must_equal 'user'
      end

      it 'must return nil if there are no GET request parameters' do
        _(ImpURI.parameter_string(http_uri)).must_be_nil
        _(ImpURI.parameters(http_uri)).must_be_nil
      end

      it 'must return true for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal true
        _(ImpURI.has_credentials?(http_uri)).must_equal true
        _(ImpURI.has_username_and_password?(http_uri)).must_equal true
        _(ImpURI.has_user_info?(http_uri)).must_equal true
        _(ImpURI.userinfo?(http_uri)).must_equal true
        _(ImpURI.credentials?(http_uri)).must_equal true
        _(ImpURI.username_and_password?(http_uri)).must_equal true
        _(ImpURI.user_info?(http_uri)).must_equal true
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal false
        _(ImpURI.has_port?(http_uri)).must_equal false
        _(ImpURI.has_portnumber?(http_uri)).must_equal false
        _(ImpURI.port_number?(http_uri)).must_equal false
        _(ImpURI.port?(http_uri)).must_equal false
        _(ImpURI.portnumber?(http_uri)).must_equal false
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return nil if there is no request URI' do
        _(ImpURI.request_uri(http_uri)).must_be_nil
      end
    end # describe 'an http URI with a username'

    describe 'an http URI with a username and password' do
      let(:http_uri){'http://user:pass@example.com/'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must parse out the username' do
        _(ImpURI.username(http_uri)).must_equal 'user'
        _(ImpURI.user(http_uri)).must_equal 'user'
      end

      it 'must parse out the password' do
        _(ImpURI.password(http_uri)).must_equal 'pass'
        _(ImpURI.pass(http_uri)).must_equal 'pass'
        _(ImpURI.passwd(http_uri)).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        _(ImpURI.userinfo(http_uri)).must_equal 'user:pass'
        _(ImpURI.credentials(http_uri)).must_equal 'user:pass'
        _(ImpURI.username_and_password(http_uri)).must_equal 'user:pass'
        _(ImpURI.user_info(http_uri)).must_equal 'user:pass'
      end

      it 'must return nil if there are no GET request parameters' do
        _(ImpURI.parameter_string(http_uri)).must_be_nil
        _(ImpURI.parameters(http_uri)).must_be_nil
      end

      it 'must return true for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal true
        _(ImpURI.has_credentials?(http_uri)).must_equal true
        _(ImpURI.has_username_and_password?(http_uri)).must_equal true
        _(ImpURI.has_user_info?(http_uri)).must_equal true
        _(ImpURI.userinfo?(http_uri)).must_equal true
        _(ImpURI.credentials?(http_uri)).must_equal true
        _(ImpURI.username_and_password?(http_uri)).must_equal true
        _(ImpURI.user_info?(http_uri)).must_equal true
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal false
        _(ImpURI.has_port?(http_uri)).must_equal false
        _(ImpURI.has_portnumber?(http_uri)).must_equal false
        _(ImpURI.port_number?(http_uri)).must_equal false
        _(ImpURI.port?(http_uri)).must_equal false
        _(ImpURI.portnumber?(http_uri)).must_equal false
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return nil if there is no request URI' do
        _(ImpURI.request_uri(http_uri)).must_be_nil
      end
    end # describe 'an http URI with a username and password'

    describe 'an http URI with one GET query parameter' do
      let(:http_uri){'http://example.com/?q=param'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        _(ImpURI.parameter_string(http_uri)).must_equal 'q=param'
      end

      it 'must parse out the parameter as a hash' do
        _(ImpURI.parameters(http_uri)).must_equal({'q' => 'param'})
      end

      it 'must return false for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal false
        _(ImpURI.has_credentials?(http_uri)).must_equal false
        _(ImpURI.has_username_and_password?(http_uri)).must_equal false
        _(ImpURI.has_user_info?(http_uri)).must_equal false
        _(ImpURI.userinfo?(http_uri)).must_equal false
        _(ImpURI.credentials?(http_uri)).must_equal false
        _(ImpURI.username_and_password?(http_uri)).must_equal false
        _(ImpURI.user_info?(http_uri)).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal false
        _(ImpURI.has_port?(http_uri)).must_equal false
        _(ImpURI.has_portnumber?(http_uri)).must_equal false
        _(ImpURI.port_number?(http_uri)).must_equal false
        _(ImpURI.port?(http_uri)).must_equal false
        _(ImpURI.portnumber?(http_uri)).must_equal false
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return the request URI' do
        _(ImpURI.request_uri(http_uri)).must_equal '/?q=param'
      end
    end # describe 'an http URI with one GET query parameter'

    describe 'an http URI with two GET query parameters' do
      let(:http_uri){'http://example.com/?q=param1&r=param2'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        _(ImpURI.parameter_string(http_uri)).must_equal 'q=param1&r=param2'
      end

      it 'must parse out the parameter as a hash' do
        _(ImpURI.parameters(http_uri)).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return false for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal false
        _(ImpURI.has_credentials?(http_uri)).must_equal false
        _(ImpURI.has_username_and_password?(http_uri)).must_equal false
        _(ImpURI.has_user_info?(http_uri)).must_equal false
        _(ImpURI.userinfo?(http_uri)).must_equal false
        _(ImpURI.credentials?(http_uri)).must_equal false
        _(ImpURI.username_and_password?(http_uri)).must_equal false
        _(ImpURI.user_info?(http_uri)).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal false
        _(ImpURI.has_port?(http_uri)).must_equal false
        _(ImpURI.has_portnumber?(http_uri)).must_equal false
        _(ImpURI.port_number?(http_uri)).must_equal false
        _(ImpURI.port?(http_uri)).must_equal false
        _(ImpURI.portnumber?(http_uri)).must_equal false
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return the request URI' do
        _(ImpURI.request_uri(http_uri)).must_equal '/?q=param1&r=param2'
      end
    end # describe 'an http URI with two GET query parameters'

    describe 'an http URI with two GET query parameters separated by a semicolon' do
      let(:http_uri){'http://example.com/?q=param1;r=param2'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must parse out the paramter string' do
        _(ImpURI.parameter_string(http_uri)).must_equal 'q=param1;r=param2'
      end

      it 'must parse out the parameter as a hash' do
        _(ImpURI.parameters(http_uri)).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return false for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal false
        _(ImpURI.has_credentials?(http_uri)).must_equal false
        _(ImpURI.has_username_and_password?(http_uri)).must_equal false
        _(ImpURI.has_user_info?(http_uri)).must_equal false
        _(ImpURI.userinfo?(http_uri)).must_equal false
        _(ImpURI.credentials?(http_uri)).must_equal false
        _(ImpURI.username_and_password?(http_uri)).must_equal false
        _(ImpURI.user_info?(http_uri)).must_equal false
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return false for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal false
        _(ImpURI.has_port?(http_uri)).must_equal false
        _(ImpURI.has_portnumber?(http_uri)).must_equal false
        _(ImpURI.port_number?(http_uri)).must_equal false
        _(ImpURI.port?(http_uri)).must_equal false
        _(ImpURI.portnumber?(http_uri)).must_equal false
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return the request URI' do
        _(ImpURI.request_uri(http_uri)).must_equal '/?q=param1;r=param2'
      end
    end # describe 'an http URI with two GET query parameters separated by a semicolon'

    describe 'an http URI with the lot' do
      let(:http_uri){'http://user:pass@example.com:8080/path/to/resource?q=param1&r=param2'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must parse out the path' do
        _(ImpURI.path(http_uri)).must_equal '/path/to/resource'
      end

      it 'must parse out the port number' do
        _(ImpURI.port(http_uri)).must_equal '8080'
        _(ImpURI.port_number(http_uri)).must_equal '8080'
        _(ImpURI.port_number(http_uri)).must_equal '8080'
      end

      it 'must parse out the username' do
        _(ImpURI.username(http_uri)).must_equal 'user'
        _(ImpURI.user(http_uri)).must_equal 'user'
      end

      it 'must parse out the password' do
        _(ImpURI.password(http_uri)).must_equal 'pass'
        _(ImpURI.pass(http_uri)).must_equal 'pass'
        _(ImpURI.passwd(http_uri)).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        _(ImpURI.userinfo(http_uri)).must_equal 'user:pass'
        _(ImpURI.credentials(http_uri)).must_equal 'user:pass'
        _(ImpURI.username_and_password(http_uri)).must_equal 'user:pass'
        _(ImpURI.user_info(http_uri)).must_equal 'user:pass'
      end

      it 'must parse out the paramter string' do
        _(ImpURI.parameter_string(http_uri)).must_equal 'q=param1&r=param2'
      end

      it 'must parse out the parameter as a hash' do
        _(ImpURI.parameters(http_uri)).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return true for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal true
        _(ImpURI.has_credentials?(http_uri)).must_equal true
        _(ImpURI.has_username_and_password?(http_uri)).must_equal true
        _(ImpURI.has_user_info?(http_uri)).must_equal true
        _(ImpURI.userinfo?(http_uri)).must_equal true
        _(ImpURI.credentials?(http_uri)).must_equal true
        _(ImpURI.username_and_password?(http_uri)).must_equal true
        _(ImpURI.user_info?(http_uri)).must_equal true
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return true for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal true
        _(ImpURI.has_port?(http_uri)).must_equal true
        _(ImpURI.has_portnumber?(http_uri)).must_equal true
        _(ImpURI.port_number?(http_uri)).must_equal true
        _(ImpURI.port?(http_uri)).must_equal true
        _(ImpURI.portnumber?(http_uri)).must_equal true
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return the request URI' do
        _(ImpURI.request_uri(http_uri)).must_equal '/path/to/resource?q=param1&r=param2'
      end
    end # describe 'an http URI with the lot'

    describe 'an http URI with the lot and a semicolon path separator' do
      let(:http_uri){'http://user:pass@example.com:8080/path/to/resource?q=param1;r=param2'}

      it 'must parse out the scheme' do
        _(ImpURI.scheme(http_uri)).must_equal 'http'
        _(ImpURI.protocol(http_uri)).must_equal 'http'
        _(ImpURI.scheme_name(http_uri)).must_equal 'http'
      end

      it 'must parse out the domain name' do
        _(ImpURI.hostname(http_uri)).must_equal 'example.com'
        _(ImpURI.host(http_uri)).must_equal 'example.com'
      end

      it 'must parse out the path' do
        _(ImpURI.path(http_uri)).must_equal '/path/to/resource'
      end

      it 'must parse out the port number' do
        _(ImpURI.port(http_uri)).must_equal '8080'
        _(ImpURI.port_number(http_uri)).must_equal '8080'
        _(ImpURI.port_number(http_uri)).must_equal '8080'
      end

      it 'must parse out the username' do
        _(ImpURI.username(http_uri)).must_equal 'user'
        _(ImpURI.user(http_uri)).must_equal 'user'
      end

      it 'must parse out the password' do
        _(ImpURI.password(http_uri)).must_equal 'pass'
        _(ImpURI.pass(http_uri)).must_equal 'pass'
        _(ImpURI.passwd(http_uri)).must_equal 'pass'
      end

      it 'must return the userinfo string' do
        _(ImpURI.userinfo(http_uri)).must_equal 'user:pass'
        _(ImpURI.credentials(http_uri)).must_equal 'user:pass'
        _(ImpURI.username_and_password(http_uri)).must_equal 'user:pass'
        _(ImpURI.user_info(http_uri)).must_equal 'user:pass'
      end

      it 'must parse out the paramter string' do
        _(ImpURI.parameter_string(http_uri)).must_equal 'q=param1;r=param2'
      end

      it 'must parse out the parameter as a hash' do
        _(ImpURI.parameters(http_uri)).must_equal({'q' => 'param1', 'r' => 'param2'})
      end

      it 'must return true for has_userinfo?()' do
        _(ImpURI.has_userinfo?(http_uri)).must_equal true
        _(ImpURI.has_credentials?(http_uri)).must_equal true
        _(ImpURI.has_username_and_password?(http_uri)).must_equal true
        _(ImpURI.has_user_info?(http_uri)).must_equal true
        _(ImpURI.userinfo?(http_uri)).must_equal true
        _(ImpURI.credentials?(http_uri)).must_equal true
        _(ImpURI.username_and_password?(http_uri)).must_equal true
        _(ImpURI.user_info?(http_uri)).must_equal true
      end

      it 'must return true for has_scheme?()' do
        _(ImpURI.has_scheme?(http_uri)).must_equal true
        _(ImpURI.has_protocol?(http_uri)).must_equal true
        _(ImpURI.has_scheme_name?(http_uri)).must_equal true
        _(ImpURI.scheme?(http_uri)).must_equal true
        _(ImpURI.protocol?(http_uri)).must_equal true
        _(ImpURI.scheme_name?(http_uri)).must_equal true
      end

      it 'must return false for has_colon_path_separator?()' do
        _(ImpURI.colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.has_colon_path_separator?(http_uri)).must_equal false
        _(ImpURI.uses_colon_path_separator?(http_uri)).must_equal false
      end

      it 'must return true for has_port_number?()' do
        _(ImpURI.has_port_number?(http_uri)).must_equal true
        _(ImpURI.has_port?(http_uri)).must_equal true
        _(ImpURI.has_portnumber?(http_uri)).must_equal true
        _(ImpURI.port_number?(http_uri)).must_equal true
        _(ImpURI.port?(http_uri)).must_equal true
        _(ImpURI.portnumber?(http_uri)).must_equal true
      end

      it 'must return false for is_ssh?()' do
        _(ImpURI.is_ssh?(http_uri)).must_equal false
      end

      it 'must return the request URI' do
        _(ImpURI.request_uri(http_uri)).must_equal '/path/to/resource?q=param1;r=param2'
      end
    end # describe 'an http URI with the lot and a semicolon path separator'

    describe 'an ssh identifier' do
      let(:ssh_identifier){'username@example.com:~account'}

      it 'must return a username' do
        _(ImpURI.username(ssh_identifier)).must_equal 'username'
      end

      it 'must correctly determine if it has user info' do
        _(ImpURI.credentials?(ssh_identifier)).must_equal false
        _(ImpURI.username_and_password?(ssh_identifier)).must_equal false
        _(ImpURI.user_info?(ssh_identifier)).must_equal false
        _(ImpURI.userinfo?(ssh_identifier)).must_equal false
        _(ImpURI.has_credentials?(ssh_identifier)).must_equal false
        _(ImpURI.has_username_and_password?(ssh_identifier)).must_equal false
        _(ImpURI.has_user_info?(ssh_identifier)).must_equal false
        _(ImpURI.has_userinfo?(ssh_identifier)).must_equal false
      end

      it 'must correctly determine if it has a scheme' do
        _(ImpURI.has_scheme?(ssh_identifier)).must_equal false
        _(ImpURI.has_protocol?(ssh_identifier)).must_equal false
        _(ImpURI.has_scheme_name?(ssh_identifier)).must_equal false
        _(ImpURI.scheme?(ssh_identifier)).must_equal false
        _(ImpURI.protocol?(ssh_identifier)).must_equal false
        _(ImpURI.scheme_name?(ssh_identifier)).must_equal false
      end

      it 'must correctly determine if it has a colon path separator' do
        _(ImpURI.colon_path_separator?(ssh_identifier)).must_equal true
        _(ImpURI.has_colon_path_separator?(ssh_identifier)).must_equal true
        _(ImpURI.uses_colon_path_separator?(ssh_identifier)).must_equal true
      end

      it 'must correctly determine if it has a port number' do
        _(ImpURI.has_port_number?(ssh_identifier)).must_equal false
        _(ImpURI.has_port?(ssh_identifier)).must_equal false
        _(ImpURI.has_portnumber?(ssh_identifier)).must_equal false
        _(ImpURI.port_number?(ssh_identifier)).must_equal false
        _(ImpURI.port?(ssh_identifier)).must_equal false
        _(ImpURI.portnumber?(ssh_identifier)).must_equal false
      end

      it 'must return true for is_ssh?()' do
        _(ImpURI.is_ssh?(ssh_identifier)).must_equal true
      end

      it 'must return hostname_and_path when requested' do
        _(ImpURI.hostname_and_path(ssh_identifier)).must_equal 'example.com:~account'
      end

      it 'must return hostname_and_port_number when requested' do
        _(ImpURI.hostname_and_port_number(ssh_identifier)).must_equal 'example.com'
      end

      it 'must return a hostname' do
        _(ImpURI.hostname(ssh_identifier)).must_equal 'example.com'
      end

      it 'must return a path' do
        _(ImpURI.path(ssh_identifier)).must_equal '~account'
      end
    end # describe 'an ssh identifier'

    describe 'an ssh identifier as per Github' do
      let(:ssh_identifier){'git@github.com:thoran/ImpURI.git'}

      it 'must return a username' do
        _(ImpURI.username(ssh_identifier)).must_equal 'git'
      end

      it 'must correctly determine if it has user info' do
        _(ImpURI.credentials?(ssh_identifier)).must_equal false
        _(ImpURI.username_and_password?(ssh_identifier)).must_equal false
        _(ImpURI.user_info?(ssh_identifier)).must_equal false
        _(ImpURI.userinfo?(ssh_identifier)).must_equal false
        _(ImpURI.has_credentials?(ssh_identifier)).must_equal false
        _(ImpURI.has_username_and_password?(ssh_identifier)).must_equal false
        _(ImpURI.has_user_info?(ssh_identifier)).must_equal false
        _(ImpURI.has_userinfo?(ssh_identifier)).must_equal false
      end

      it 'must correctly determine if it has a scheme' do
        _(ImpURI.has_scheme?(ssh_identifier)).must_equal false
        _(ImpURI.has_protocol?(ssh_identifier)).must_equal false
        _(ImpURI.has_scheme_name?(ssh_identifier)).must_equal false
        _(ImpURI.scheme?(ssh_identifier)).must_equal false
        _(ImpURI.protocol?(ssh_identifier)).must_equal false
        _(ImpURI.scheme_name?(ssh_identifier)).must_equal false
      end

      it 'must correctly determine if it has a colon path separator' do
        _(ImpURI.colon_path_separator?(ssh_identifier)).must_equal true
        _(ImpURI.has_colon_path_separator?(ssh_identifier)).must_equal true
        _(ImpURI.uses_colon_path_separator?(ssh_identifier)).must_equal true
      end

      it 'must correctly determine if it has a port number' do
        _(ImpURI.has_port_number?(ssh_identifier)).must_equal false
        _(ImpURI.has_port?(ssh_identifier)).must_equal false
        _(ImpURI.has_portnumber?(ssh_identifier)).must_equal false
        _(ImpURI.port_number?(ssh_identifier)).must_equal false
        _(ImpURI.port?(ssh_identifier)).must_equal false
        _(ImpURI.portnumber?(ssh_identifier)).must_equal false
      end

      it 'must return true for is_ssh?()' do
        _(ImpURI.is_ssh?(ssh_identifier)).must_equal true
      end

      it 'must return hostname_and_path when requested' do
        _(ImpURI.hostname_and_path(ssh_identifier)).must_equal 'github.com:thoran/ImpURI.git'
      end

      it 'must return hostname_and_port_number when requested' do
        _(ImpURI.hostname_and_port_number(ssh_identifier)).must_equal 'github.com'
      end

      it 'must return a hostname' do
        _(ImpURI.hostname(ssh_identifier)).must_equal 'github.com'
      end

      it 'must return a path' do
        _(ImpURI.path(ssh_identifier)).must_equal 'thoran/ImpURI.git'
      end
    end # describe 'an ssh identifier as per Github'

  end
end
