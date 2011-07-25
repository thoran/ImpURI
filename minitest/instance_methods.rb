# Test @impuri/instance_methods

# 20110725
# 0.6.0

# Todo:
# 1. scheme, protocol  
# 2. userinfo, credentials, username_and_password, user_info, userinfo
# 3. username, user, username
# 4. password, pass, passwd, password
# 5. hostname, host
# 6. port_number, port, :portnumber
# 7. path
# 8. request_uri
# 9. parameter_string
# 10. parameters
# 11. scheme_with_separator, protocol_with_separator
# 12. userinfo_with_separator, credentials_with_separator, :username_and_password_with_separator, :user_info_with_separator
# 13. hostname_optionally_with_port_number, hostname_optionally_with_portnumber
# 14. to_s
# 15. to_h

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'ImpURI'
require 'minitest/autorun'

describe ImpURI do
  
  describe 'ImpURI instance methods' do
    
    describe 'a very simple http URI' do
      before do
        @impuri = ImpURI.new('http://example.com')
      end
      
      it 'should parse out the scheme' do
        @impuri.scheme.must_equal 'http'
        @impuri.protocol.must_equal 'http'
        @impuri.scheme_name.must_equal 'http'
      end
      
      it 'should parse out the domain name' do
        @impuri.hostname.must_equal 'example.com'
        @impuri.host.must_equal 'example.com'
      end
      
      it 'should return nil if there is no path' do
        @impuri.path.must_equal nil
      end
      
      it 'should return nil if there are no GET request parameters' do
        @impuri.parameter_string.must_equal nil
        @impuri.parameters.must_equal nil
      end
      
      it 'should return false for has_userinfo?()' do
        @impuri.has_userinfo?.must_equal false
        @impuri.has_credentials?.must_equal false
        @impuri.has_username_and_password?.must_equal false
        @impuri.has_user_info?.must_equal false
      end
      
      it 'should return true for has_scheme?()' do
        @impuri.has_scheme?.must_equal true
        @impuri.has_protocol?.must_equal true
        @impuri.has_scheme_name?.must_equal true
      end
      
      it 'should return false for has_colon_path_separator?()' do
        @impuri.has_colon_path_separator?.must_equal false
        @impuri.uses_colon_path_separator?.must_equal false
      end
      
      it 'should return false for has_port_number?()' do
        @impuri.has_port_number?.must_equal false
        @impuri.has_port?.must_equal false
      end
      
      it 'should return nil if there is no request URI' do
        @impuri.request_uri.must_equal nil
      end
    end # describe 'a very simple http URI'
    
  end # describe 'ImpURI instance methods'
  
end # describe ImpURI
