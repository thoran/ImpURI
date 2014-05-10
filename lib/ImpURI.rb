# ImpURI

# 20110725
# 0.6.0

# Description: A cleaner and simpler URI and ssh/scp resource parser for Ruby.  

# Todo: 
# 1. Handle port numbers.  Done as of 0.1.0.  
# 2. Create strict and non-strict parsing modes, which will either accept or reject non-URI ssh/scp formatted strings if they are supplied.  Done as of 0.2.0.  
# 3. Doesn't handle some of the funkier URI's like: ssh:// with keys in the userinfo section, mailto: (no ://, but merely :), and ldap://.  

# Changes since 0.5: 
# 1. /alias_methods :host_and_path/alias_methods :host_and_path, :hostname_and_path/
# 2. Swapped implementation of ImpURI.request_uri() for ImpURI.path(), since ImpURI.path() was giving the response that ImpURI.request_uri() should have been.  
# 3. ~ ImpURI.path(), so as it removes any request parameters.  
# 4. + ImpURI.has_parameters?().  
# 5. + alias_methods :has_get_parameters?, :has_parameters.  
# 6. + alias_methods :query_string, :parameter_string.  
# 7. + alias_methods :query, :parameters.  
# 8. + ImpURI.has_semicolon_parameter_separator?
# 9. + alias_methods :has_semicolon_query_separator?, :has_semicolon_parameter_separator?
# 10. + ImpURIhas_ampersand_parameter_separator?
# 11. + alias_methods :has_ampersand_query_separator?, :has_ampersand_parameter_separator?
# 12. + ImpURI.parameter_separator.  
# 13. + alias_methods :query_separator, :parameter_separator
# 14. ~ ImpURI.parameters, so as handles ampersand and semicolon parameter separators.  
# 15. ~ ImpURI.parameter_string, so as it checks for parameters first before.  
# 16. + ImpURI#has_userinfo?.  
# 17. + alias_methods :has_credentials?, :has_username_and_password?, :has_user_info?, :has_userinfo?.  
# 18. + ImpURI#has_scheme?.  
# 19. + alias_methods :has_protocol?, :has_scheme_name?, :has_scheme?.  
# 20. + ImpURI#has_colon_path_separator?.  
# 21. + alias_methods :uses_colon_path_separator?, :has_colon_path_separator?.  
# 22. + ImpURI#has_port_number?.  
# 23. + alias_methods :has_port?, :has_port_number?.  
# 24. + ImpURI#has_parameters?.  
# 25. + alias_methods :has_get_parameters?, :has_parameters?.  
# 26. + ImpURI#has_semicolon_parameter_separator?.  
# 27. + alias_methods :has_semicolon_query_separator?, :has_semicolon_parameter_separator?.  
# 28. + ImpURI#has_ampersand_parameter_separator?.  
# 29. + alias_methods :has_ampersand_query_separator?, :has_ampersand_parameter_separator?.  
# 30. ~ /alias_methods :protocol, :scheme/alias_methods :protocol, :scheme_name, :scheme/.  
# 31. ~ README with some very small edits.  

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
    
    def request_uri(uri) # For the instance method providing compatibility to Ruby's URI.  
      path = hostname_and_path(uri).split('/').all_but_first.join('/')
      path.blank? ? nil : '/' + path
    end
    
    def path(uri)
      if non_nil_request_uri = request_uri(uri)
        request_uri = non_nil_request_uri.split('?').first
        request_uri.blank? ? nil : request_uri
      else
        nil
      end
    end
    
    def parameter_string(uri)
      parameter_string = has_parameters?(uri) ? request_uri(uri).split('?').last : nil
      parameter_string.blank? ? nil : parameter_string
    end
    alias_methods :query_string, :parameter_string
    
    def parameters(uri)
      if non_nil_parameter_string = parameter_string(uri)
        h = {}
        parameter_parts = (
          case parameter_separator(uri)
          when '&'; non_nil_parameter_string.split('&')
          when ';'; non_nil_parameter_string.split(';')
          else [non_nil_parameter_string]
          end
        )
        parameter_parts.each do |pairs|
          a = pairs.split('=')
          h[a[0]] = a[1]
        end
        h
      else
        nil
      end
    end
    alias_methods :query, :parameters
    
    def hostname_and_path(uri)
      if has_userinfo?(uri)
        uri.split('@').last
      else
        all_but_scheme(uri)
      end
    end
    alias_methods :host_and_path, :hostname_and_path
    
    def hostname_and_port_number(uri)
      if has_colon_path_separator?(uri)
        hostname_and_path(uri).split(':').all_but_last.join(':')
      else
        hostname_and_path(uri).split('/').first
      end
    end
    alias_methods :host_and_port, :host_and_portnumber, :host_and_port_number, :hostname_and_port, :hostname_and_portnumber, :hostname_and_port_number
    
    def has_userinfo?(uri)
      uri.split('/').all_but_last.join('/').match(/@/) ? true : false
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
    
    def has_parameters?(uri)
      uri.match(/\?/) ? true : false
    end
    alias_methods :has_get_parameters?, :has_parameters?
    
    def has_semicolon_parameter_separator?(uri)
      uri.match(/;/) ? true : false
    end
    alias_methods :has_semicolon_query_separator?, :has_semicolon_parameter_separator?
    
    def has_ampersand_parameter_separator?(uri)
      uri.match(/&/) ? true : false
    end
    alias_methods :has_ampersand_query_separator?, :has_ampersand_parameter_separator?
    
    def parameter_separator(uri)
      if has_ampersand_parameter_separator?(uri)
        '&'
      elsif has_semicolon_parameter_separator?(uri)
        ';'
      else
        nil
      end
    end
    alias_methods :query_separator, :parameter_separator
    
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
        "#{hostname(uri)}:#{port_number(uri)}"
      end
    end
    alias_methods :hostname_optionally_with_portnumber, :hostname_optionally_with_port_number
    
  end # class << self
  
  def initialize(uri, *args)
    options = args.extract_options!
    if options[:strict]
      raise SchemeMissingError if !ImpURI.has_scheme?(uri)
      raise ColonPathSeparatorsNotAllowedError if ImpURI.has_colon_path_separator?(uri)
    end
    @uri = uri
  end
  
  def scheme
    @scheme ||= ImpURI.scheme(@uri)
  end
  alias_methods :protocol, :scheme_name, :scheme
  
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
  alias_methods :hostname_optionally_with_portnumber, :hostname_optionally_with_port_number
  
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
  
  def has_userinfo?
    ImpURI.has_userinfo?(@uri)
  end
  alias_methods :has_credentials?, :has_username_and_password?, :has_user_info?, :has_userinfo?
  
  def has_scheme?
    ImpURI.has_scheme?(@uri)
  end
  alias_methods :has_protocol?, :has_scheme_name?, :has_scheme?
  
  def has_colon_path_separator?
    ImpURI.has_colon_path_separator?(@uri)
  end
  alias_methods :uses_colon_path_separator?, :has_colon_path_separator?
  
  def has_port_number?
    ImpURI.has_port_number?(@uri)
  end
  alias_methods :has_port?, :has_port_number?
  
  def has_parameters?
    ImpURI.has_parameters?(@uri)
  end
  alias_methods :has_get_parameters?, :has_parameters?
  
  def has_semicolon_parameter_separator?
    ImpURI.has_semicolon_parameter_separator?(@uri)
  end
  alias_methods :has_semicolon_query_separator?, :has_semicolon_parameter_separator?
  
  def has_ampersand_parameter_separator?
    ImpURI.has_ampersand_parameter_separator?(@uri)
  end
  alias_methods :has_ampersand_query_separator?, :has_ampersand_parameter_separator?
  
end
