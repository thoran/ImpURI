# ImpURI

# 20110713
# 0.5.0

# Description: A cleaner and simpler URI and ssh/scp resource parser for Ruby.  

# Raison'd'etre: 
# 1. I wrote it because Ruby's standard URI library doesn't handle ssh/scp resource descriptors, which are the near-to, not quite URI, but commonly used, ssh/scp way of describing a network addressable resource: username:password@host:/path.  URI's have a scheme at the start, and the path begins with only a forward slash, whereas an ssh/scp resource has no scheme, and the path begins with a colon and a slash.  I wanted to be able to handle both.  
# 2. Ruby's standard URI class does too much.  It is overblown and untidy.  I just want it to break the strings down and that's it.  I don't want any scheme interpolation from the port number, nor from the host name, or any other 'smarts'.  

# Examples: 
# uri = ImpURI.parse('scheme://user:pass@hostname.domain.name:20/path/to/resource?q=param')
# OR
# uri = ImpURI.new('scheme://user:pass@hostname.domain.name:20/path/to/resource?q=param')
# => an object of class URI
# uri.scheme OR uri.protocol
# => 'scheme'
# uri.userinfo OR uri.credentials OR uri.user_info OR uri.username_and_password
# => 'user:pass'
# uri.user OR uri.username
# => 'user'
# uri.pass OR uri.passwd OR uri.password
# => 'pass
# uri.host OR uri.hostname
# => 'hostname.domain.name'
# uri.port OR uri.portnumber OR uri.port_number
# => '20'
# uri.path
# => '/path/to/resource'
# uri.parameter_string
# => 'q=param'
# uri.parameters
# => {q => param}

# Todo: 
# 1. Handle port numbers.  Done as of 0.1.0.  
# 2. Create strict and non-strict parsing modes, which will either accept or reject non-URI ssh/scp formatted strings if they are supplied.  Done as of 0.2.0.  
# 3. Doesn't handle some of the funkier URI's like: ssh:// with keys in the userinfo section, mailto: (no ://, but merely :), and ldap://.  

# Changes since 0.5: 
# (Copied in supporting methods.)
# 1. + lib/_meta/blankQ.  
# 2. + lib/Array/all_but_first.  
# 3. + lib/Array/all_but_last.  
# 4. + lib/Array/blankQ.  
# 5. + lib/Array/extract_optionsX.  
# 6. + lib/Array/firstX.  
# 7. + lib/Array/lastX.  
# 8. + lib/FalseClass/blankQ.  
# 9. + lib/Hash/blankQ.  
# 10. + lib/Module/alias_methods.  
# 11. + lib/NilClass/blankQ.  
# 12. + lib/Numeric/blankQ.  
# 13. + lib/Object/blankQ.  
# 14. + lib/String/blankQ.  
# 15. + lib/TrueClass/blankQ.  
# 16. ~ ImpURI.parameters(), so as it will not fail if ImpURI.parameter_string returns nil.  
# 17. /self.class/ImpURI/, as it is probably marginally quicker and arguably clearer.  

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require '_meta/blankQ'
require 'Array/all_but_first'
require 'Array/all_but_last'
require 'Array/extract_optionsX'
require 'Module/alias_methods'

class ImpURI
  
  class SchemeMissingError < RuntimeError; end
  class ColonPathSeparatorsNotAllowedError < RuntimeError; end
  
  class << self
    
    attr_accessor :strict
    
    def parse(uri, *args)
      ImpURI.new(uri, *args)
    end
    
    def scheme(uri)
      if has_scheme?(uri)
        uri.split('://').first
      else
        nil
      end
    end
    alias_methods :protocol, :scheme_name, :scheme
    
    def userinfo(uri)
      if has_userinfo?(uri)
        if all_but_scheme(uri).split('@').size > 1
          all_but_scheme(uri).split('@').all_but_last.join('@')
        else
          all_but_scheme(uri).split('@').first
        end
      else
        nil
      end
    end
    alias_methods :credentials, :username_and_password, :user_info, :userinfo
    
    def username(uri)
      if has_userinfo?(uri)
        userinfo(uri).split(':')[0]
      else
        nil
      end
    end
    alias_methods :user, :username
    
    def password(uri)
      if has_userinfo?(uri)
        userinfo(uri).split(':')[1]
      else
        nil
      end
    end
    alias_methods :pass, :passwd, :password
    
    def hostname(uri)
      hostname_and_port_number(uri).split(':').first
    end
    alias_methods :host, :hostname
    
    def port_number(uri)
      if has_port_number?(uri)
        hostname_and_port_number(uri).split(':').last
      else
        nil
      end
    end
    alias_methods :port, :portnumber, :port_number
    
    def path(uri)
      path = hostname_and_path(uri).split('/').all_but_first.join('/')
      path.blank? ? nil : '/' + path
    end
    
    def request_uri(uri) # For the instance method providing compatibility to Ruby's URI.  
      request_uri = path(uri).split('?').first
      request_uri.blank? ? nil : request_uri
    end
    
    def parameter_string(uri)
      parameter_string = path(uri).split('?').last
      parameter_string.blank? ? nil : parameter_string
    end
    
    def parameters(uri)
      if non_nil_parameter_string = parameter_string(uri)
        h = {}
        non_nil_parameter_string.split('&').each do |pairs|
          a = pairs.split('=')
          h[a[0]] = a[1]
        end
        h
      else
        nil
      end
    end
    
    def hostname_and_path(uri)
      if has_userinfo?(uri)
        uri.split('@').last
      else
        all_but_scheme(uri)
      end
    end
    alias_methods :host_and_path
    
    def hostname_and_port_number(uri)
      if has_colon_path_separator?(uri)
        hostname_and_path(uri).split(':').all_but_last.join(':')
      else
        hostname_and_path(uri).split('/').first
      end
    end
    alias_methods :host_and_port, :host_and_portnumber, :host_and_port_number, :hostname_and_port, :hostname_and_portnumber, :hostname_and_port_number
    
    def has_userinfo?(uri)
      uri.match(/@/) ? true : false
    end
    alias_methods :has_credentials?, :has_username_and_password?, :has_user_info?, :has_userinfo?
    
    def has_scheme?(uri)
      uri.match(/^[a-z]*?:\/\//) ? true : false
    end
    alias_methods :has_protocol?, :has_scheme_name?, :has_scheme?
    
    def has_colon_path_separator?(uri)
      hostname_and_path(uri).match(/:\//) ? true : false
    end
    alias_methods :uses_colon_path_separator?, :has_colon_path_separator?
    
    def has_port_number?(uri)
      hostname_and_path(uri).match(/(:\d+\/)|(:\d+$)/) ? true : false
    end
    alias_methods :has_port?, :has_port_number?
    
    def all_but_scheme(uri)
      uri.split('://').last
    end
    
    def all_but_userinfo(uri)
      if has_userinfo?(uri)
        "#{scheme_with_separator(uri)}#{hostname_and_path(uri)}"
      else
        hostname_and_path(uri)
      end
    end
    
    def scheme_with_separator(uri)
      if scheme(uri).blank?
        ''
      else
        "#{scheme(uri)}://"
      end
    end
    alias_methods :protocol_with_separator, :scheme_with_separator
    
    def userinfo_with_separator(uri)
      if username(uri).blank?
        ''
      elsif password(uri).blank?
        "#{username(uri)}@"
      else
        "#{username(uri)}:#{password(uri)}@"
      end
    end
    alias_methods :credentials_with_separator, :username_and_password_with_separator, :user_info_with_separator, :userinfo_with_separator
    
    def hostname_optionally_with_port_number(uri)
      if port_number(uri).blank?
        "#{hostname(uri)}"
      else
        "#{username(uri)}:#{port_number(uri)}@"
      end
    end
    alias_methods :hostname_optionally_with_portnumber, :hostname_optionally_with_port_number
    
  end # class << self
  
  def initialize(uri, *args)
    @uri = uri
    options = args.extract_options!
    if options[:strict]
      raise SchemeMissingError if !ImpURI.has_scheme?(uri)
      raise ColonPathSeparatorsNotAllowedError if ImpURI.has_colon_path_separator?(uri)
    end
  end
  
  def scheme
    @scheme ||= ImpURI.scheme(@uri)
  end
  alias_methods :protocol, :scheme
  
  def userinfo
    @userinfo ||= ImpURI.userinfo(@uri)
  end
  alias_methods :credentials, :username_and_password, :user_info, :userinfo
  
  def username
    @username ||= ImpURI.username(@uri)
  end
  alias_methods :user, :username
  
  def password
    @password ||= ImpURI.password(@uri)
  end
  alias_methods :pass, :passwd, :password
  
  def hostname
    @hostname ||= ImpURI.hostname(@uri)
  end
  alias_methods :host, :hostname
  
  def port_number
    @port_number ||= ImpURI.port_number(@uri)
  end
  alias_methods :port, :portnumber, :port_number
  
  def path
    @path ||= ImpURI.path(@uri)
  end
  
  def request_uri # For compatability with Ruby's URI.  
    @request_uri ||= ImpURI.request_uri(@uri)
  end
  
  def parameter_string
    @parameter_string ||= ImpURI.parameter_string(@uri)
  end
  
  def parameters
    @parameters ||= ImpURI.parameters(@uri)
  end
  
  def scheme_with_separator
    ImpURI.scheme_with_separator(@uri)
  end
  alias_methods :protocol_with_separator, :scheme_with_separator
  
  def userinfo_with_separator
    ImpURI.userinfo_with_separator(@uri)
  end
  alias_methods :credentials_with_separator, :username_and_password_with_separator, :user_info_with_separator, :userinfo_with_separator
  
  def hostname_optionally_with_port_number
    ImpURI.hostname_optionally_with_port_number(@uri)
  end
  alias_methods :hostname_optinally_with_portnumber, :hostname_optionally_with_port_number
  
  def to_s(use_colon_path_separator = false)
    if use_colon_path_separator
      "#{scheme_with_separator}#{userinfo_with_separator}#{hostname_optionally_with_port_number}:#{path}"
    else
      "#{scheme_with_separator}#{userinfo_with_separator}#{hostname_optionally_with_port_number}#{path}"
    end
  end
  
  def to_h
    {:scheme => scheme, :username => username, :password => password, :hostname => hostname, :port_number => port_number, :path => path}
  end
  
end
