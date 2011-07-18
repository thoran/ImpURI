# ImpURI

# 20110612
# 0.4.2

# Description: This is a non-validating parser for URI's and ssh/scp almost URI's.  

# Raison'd'etre: 
# 1. I wrote it because Ruby's standard URI class wouldn't parse the near-to, not quite URI, but commonly used, ssh/scp way of describing a network addressable resource: username:password@host:/path.  URI's have a scheme at the start, and the path begins with only a forward slash, whereas an ssh/scp resource has no scheme, and the path begins with a colon and a slash.  
# 2. Ruby's standard URI class does too much.  I just want it to break the strings down and that's it.  I don't want any scheme interpolation from the port number, nor from the host name, or any other 'smarts'.  

# History: I've run into circumstances, such as when writing git-boot, where I can't use Ruby's standard library URI class to parse ssh/scp-style network resources.  Similarly, I have recently written a class called Secrets as a way of storing usernames and passwords, or credentials in an ssh/scp-style way.  Then I decided that I wanted to be able to store URI's as well, since a username and password is only used in the context of where those are to be used, but then had to consider contending with the same sort of mucking about as I did with git-boot.  This was begun as an exploratory exercise in programming a more satisfying and general solution inside the currently being used version of Secrets for its use there and elsewhere, and so was summarily ejected.  

# Examples: 
# uri = URI.parse('scheme://user:pass@hostname.domain.name:20/path/to/resource') OR uri = URI.new('scheme://user:pass@hostname.domain.name:20/path/to/resource')
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

# Todo: 
# 1. Handle port numbers.  Done as of 0.1.0.  
# 2. Create strict and non-strict parsing modes, which will either accept or reject non-URI ssh/scp formatted strings if they are supplied.  Done as of 0.2.0.  
# 3. Doesn't handle some of the funkier URI's like: ssh:// with keys in the userinfo section, mailto: (no ://, but merely :), and ldap://.  

# Changes since 0.3: 
# 1. /URI/ImpURI/, since I was getting comflicts, which I am yet to resolve, with the standard URI class.  
# 0/1
# 2. ~ ImpURI.userinfo, if either the username or the password had an '@' in it, it would fail to parse things correctly.  
# 3. + require 'Array/all_but_last'
# 1/2
# 4. + ImpURI#request_uri for For compatability with Ruby's URI.  
# 5. + ImpURI.request_uri for the instance method providing compatibility with Ruby's URI.  
# 6. + ImpURI#parameter_string.  
# 7. + ImpURI.parameter_string.  
# 8. + ImpURI#parameters.  
# 9. + ImpURI.parameters.  

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
      h = {}
      parameter_string(uri).split('&').each do |pairs|
        a = pairs.split('=')
        h[a[0]] = a[1]
      end
      h
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
      raise SchemeMissingError if !self.class.has_scheme?(uri)
      raise ColonPathSeparatorsNotAllowedError if self.class.has_colon_path_separator?(uri)
    end
  end
  
  def scheme
    @scheme ||= self.class.scheme(@uri)
  end
  alias_methods :protocol, :scheme
  
  def userinfo
    @userinfo ||= self.class.userinfo(@uri)
  end
  alias_methods :credentials, :username_and_password, :user_info, :userinfo
  
  def username
    @username ||= self.class.username(@uri)
  end
  alias_methods :user, :username
  
  def password
    @password ||= self.class.password(@uri)
  end
  alias_methods :pass, :passwd, :password
  
  def hostname
    @hostname ||= self.class.hostname(@uri)
  end
  alias_methods :host, :hostname
  
  def port_number
    @port_number ||= self.class.port_number(@uri)
  end
  alias_methods :port, :portnumber, :port_number
  
  def path
    @path ||= self.class.path(@uri)
  end
  
  def request_uri # For compatability with Ruby's URI.  
    @request_uri ||= self.class.request_uri(@uri)
  end
  
  def parameter_string
    @parameter_string ||= self.class.parameter_string(@uri)
  end
  
  def parameters
    @parameters ||= self.class.parameters(@uri)
  end
  
  def scheme_with_separator
    self.class.scheme_with_separator(@uri)
  end
  alias_methods :protocol_with_separator, :scheme_with_separator
  
  def userinfo_with_separator
    self.class.userinfo_with_separator(@uri)
  end
  alias_methods :credentials_with_separator, :username_and_password_with_separator, :user_info_with_separator, :userinfo_with_separator
  
  def hostname_optionally_with_port_number
    self.class.hostname_optionally_with_port_number(@uri)
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
