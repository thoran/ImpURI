# Test ImpURI/class_methods

# 20110725
# 0.6.0

# Todo:
# 1. hostname_and_path, host_and_path
# 2. hostname_and_port_number, host_and_port, host_and_portnumber, host_and_port_number, hostname_and_port, hostname_and_portnumber, hostname_and_port_number
# 3. all_but_scheme
# 4. all_but_userinfo
# 5. scheme_with_separator, protocol_with_separator
# 6. userinfo_with_separator, credentials_with_separator, username_and_password_with_separator, user_info_with_separator
# 7. hostname_optionally_with_port_number, hostname_optionally_with_portnumber

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'ImpURI'
require 'minitest/autorun'

describe ImpURI do
  
  describe 'ImpURI class methods' do
    
    describe 'parse()' do
      it 'should return an object of class ImpURI' do
        ImpURI.parse('http://example.com').class.must_equal ImpURI
      end
    end
    
    describe 'a very simple http URI' do
      before do
        @http_uri = 'http://example.com'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should return nil if there is no path' do
        ImpURI.path(@http_uri).must_equal nil
      end
      
      it 'should return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end
      
      it 'should return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
      end
      
      it 'should return nil if there is no request URI' do
        ImpURI.request_uri(@http_uri).must_equal nil
      end
    end # describe 'a very simple http URI'
    
    describe 'an http URI with a port number' do
      before do
        @http_uri = 'http://example.com:8080'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should return nil if there is no path' do
        ImpURI.path(@http_uri).must_equal nil
      end
      
      it 'should parse out the port number' do
        ImpURI.port(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
      end
      
      it 'should return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end
      
      it 'should return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return true for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal true
        ImpURI.has_port?(@http_uri).must_equal true
      end

      it 'should return nil if there is no request URI' do
        ImpURI.request_uri(@http_uri).must_equal nil
      end
    end # describe 'an http URI with a port number'
    
    describe 'an http URI with a path' do
      before do
        @http_uri = 'http://example.com/path/to/resource'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should parse out the path' do
        ImpURI.path(@http_uri).must_equal '/path/to/resource'
      end
      
      it 'should return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end
      
      it 'should return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
      end
      
      it 'should return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/path/to/resource'
      end
    end # describe 'an http URI with a path'
    
    describe 'an http URI with a username' do
      before do
        @http_uri = 'http://user@example.com/'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should parse out the username' do
        ImpURI.username(@http_uri).must_equal 'user'
      end
      
      it 'should return the userinfo string' do
        ImpURI.userinfo(@http_uri).must_equal 'user'
        ImpURI.credentials(@http_uri).must_equal 'user'
        ImpURI.username_and_password(@http_uri).must_equal 'user'
        ImpURI.user_info(@http_uri).must_equal 'user'
      end
      
      it 'should return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end
      
      it 'should return true for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal true
        ImpURI.has_credentials?(@http_uri).must_equal true
        ImpURI.has_username_and_password?(@http_uri).must_equal true
        ImpURI.has_user_info?(@http_uri).must_equal true
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
      end
      
      it 'should return nil if there is no request URI' do
        ImpURI.request_uri(@http_uri).must_equal nil
      end
    end # describe 'an http URI with a username'
    
    describe 'an http URI with a username and password' do
      before do
        @http_uri = 'http://user:pass@example.com/'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should parse out the username' do
        ImpURI.username(@http_uri).must_equal 'user'
        ImpURI.user(@http_uri).must_equal 'user'
      end
      
      it 'should parse out the password' do
        ImpURI.password(@http_uri).must_equal 'pass'
        ImpURI.pass(@http_uri).must_equal 'pass'
        ImpURI.passwd(@http_uri).must_equal 'pass'
      end
      
      it 'should return the userinfo string' do
        ImpURI.userinfo(@http_uri).must_equal 'user:pass'
        ImpURI.credentials(@http_uri).must_equal 'user:pass'
        ImpURI.username_and_password(@http_uri).must_equal 'user:pass'
        ImpURI.user_info(@http_uri).must_equal 'user:pass'
      end
      
      it 'should return nil if there are no GET request parameters' do
        ImpURI.parameter_string(@http_uri).must_equal nil
        ImpURI.parameters(@http_uri).must_equal nil
      end
      
      it 'should return true for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal true
        ImpURI.has_credentials?(@http_uri).must_equal true
        ImpURI.has_username_and_password?(@http_uri).must_equal true
        ImpURI.has_user_info?(@http_uri).must_equal true
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
      end
      
      it 'should return nil if there is no request URI' do
        ImpURI.request_uri(@http_uri).must_equal nil
      end
    end # describe 'an http URI with a username and password'
    
    describe 'an http URI with one GET query parameter' do
      before do
        @http_uri = 'http://example.com/?q=param'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param'
      end
      
      it 'should parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param'})
      end
      
      it 'should return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
      end
      
      it 'should return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/?q=param'
      end
    end # describe 'an http URI with one GET query parameter'
    
    describe 'an http URI with two GET query parameters' do
      before do
        @http_uri = 'http://example.com/?q=param1&r=param2'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param1&r=param2'
      end
      
      it 'should parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param1', 'r' => 'param2'})
      end
      
      it 'should return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
      end
      
      it 'should return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/?q=param1&r=param2'
      end
    end # describe 'an http URI with two GET query parameters'
    
    describe 'an http URI with two GET query parameters separated by a semicolon' do
      before do
        @http_uri = 'http://example.com/?q=param1;r=param2'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param1;r=param2'
      end
      
      it 'should parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param1', 'r' => 'param2'})
      end
      
      it 'should return false for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal false
        ImpURI.has_credentials?(@http_uri).must_equal false
        ImpURI.has_username_and_password?(@http_uri).must_equal false
        ImpURI.has_user_info?(@http_uri).must_equal false
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return false for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal false
        ImpURI.has_port?(@http_uri).must_equal false
      end
      
      it 'should return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/?q=param1;r=param2'
      end
    end # describe 'an http URI with two GET query parameters separated by a semicolon'
    
    describe 'an http URI with the lot' do
      before do
        @http_uri = 'http://user:pass@example.com:8080/path/to/resource?q=param1&r=param2'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should parse out the path' do
        ImpURI.path(@http_uri).must_equal '/path/to/resource'
      end
      
      it 'should parse out the port number' do
        ImpURI.port(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
      end
      
      it 'should parse out the username' do
        ImpURI.username(@http_uri).must_equal 'user'
        ImpURI.user(@http_uri).must_equal 'user'
      end
      
      it 'should parse out the password' do
        ImpURI.password(@http_uri).must_equal 'pass'
        ImpURI.pass(@http_uri).must_equal 'pass'
        ImpURI.passwd(@http_uri).must_equal 'pass'
      end
      
      it 'should return the userinfo string' do
        ImpURI.userinfo(@http_uri).must_equal 'user:pass'
        ImpURI.credentials(@http_uri).must_equal 'user:pass'
        ImpURI.username_and_password(@http_uri).must_equal 'user:pass'
        ImpURI.user_info(@http_uri).must_equal 'user:pass'
      end
      
      it 'should parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param1&r=param2'
      end
      
      it 'should parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param1', 'r' => 'param2'})
      end
      
      it 'should return true for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal true
        ImpURI.has_credentials?(@http_uri).must_equal true
        ImpURI.has_username_and_password?(@http_uri).must_equal true
        ImpURI.has_user_info?(@http_uri).must_equal true
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return true for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal true
        ImpURI.has_port?(@http_uri).must_equal true
      end
      
      it 'should return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/path/to/resource?q=param1&r=param2'
      end
    end # describe 'an http URI with the lot'
    
    describe 'an http URI with the lot and a semicolon path separator' do
      before do
        @http_uri = 'http://user:pass@example.com:8080/path/to/resource?q=param1;r=param2'
      end
      
      it 'should parse out the scheme' do
        ImpURI.scheme(@http_uri).must_equal 'http'
        ImpURI.protocol(@http_uri).must_equal 'http'
        ImpURI.scheme_name(@http_uri).must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        ImpURI.hostname(@http_uri).must_equal 'example.com'
        ImpURI.host(@http_uri).must_equal 'example.com'
      end
      
      it 'should parse out the path' do
        ImpURI.path(@http_uri).must_equal '/path/to/resource'
      end
      
      it 'should parse out the port number' do
        ImpURI.port(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
        ImpURI.port_number(@http_uri).must_equal '8080'
      end
      
      it 'should parse out the username' do
        ImpURI.username(@http_uri).must_equal 'user'
        ImpURI.user(@http_uri).must_equal 'user'
      end
      
      it 'should parse out the password' do
        ImpURI.password(@http_uri).must_equal 'pass'
        ImpURI.pass(@http_uri).must_equal 'pass'
        ImpURI.passwd(@http_uri).must_equal 'pass'
      end
      
      it 'should return the userinfo string' do
        ImpURI.userinfo(@http_uri).must_equal 'user:pass'
        ImpURI.credentials(@http_uri).must_equal 'user:pass'
        ImpURI.username_and_password(@http_uri).must_equal 'user:pass'
        ImpURI.user_info(@http_uri).must_equal 'user:pass'
      end
      
      it 'should parse out the paramter string' do
        ImpURI.parameter_string(@http_uri).must_equal 'q=param1;r=param2'
      end
      
      it 'should parse out the parameter as a hash' do
        ImpURI.parameters(@http_uri).must_equal({'q' => 'param1', 'r' => 'param2'})
      end
      
      it 'should return true for has_userinfo?()' do
        ImpURI.has_userinfo?(@http_uri).must_equal true
        ImpURI.has_credentials?(@http_uri).must_equal true
        ImpURI.has_username_and_password?(@http_uri).must_equal true
        ImpURI.has_user_info?(@http_uri).must_equal true
      end
      
      it 'should return true for has_scheme?()' do
        ImpURI.has_scheme?(@http_uri).must_equal true
        ImpURI.has_protocol?(@http_uri).must_equal true
        ImpURI.has_scheme_name?(@http_uri).must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        ImpURI.has_colon_path_separator?(@http_uri).must_equal false
        ImpURI.uses_colon_path_separator?(@http_uri).must_equal false
      end
      
      it 'should return true for has_port_number?()' do
        ImpURI.has_port_number?(@http_uri).must_equal true
        ImpURI.has_port?(@http_uri).must_equal true
      end
      
      it 'should return the request URI' do
        ImpURI.request_uri(@http_uri).must_equal '/path/to/resource?q=param1;r=param2'
      end
    end # describe 'an http URI with the lot and a semicolon path separator'
    
  end # describe 'ImpURI class methods'
  
end # describe ImpURI
