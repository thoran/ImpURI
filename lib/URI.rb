# URI

# 2010.05.08
# 0.1.0

# Description: This is a non-validating parser for URI's.  

# Raison'd'etre: 
# I wrote it because Ruby's standard URI class wouldn't parse the non-URI, but commonly used, ssh standard way of describing a login string... 
# username:password@host:/path.  

# History: I've run into circumstances, such as when writing git-boot, where I can't use Ruby's standard library URI class to parse ssh/scp-style network resources.  Similarly, I have recently written a class called Secrets as a way of storing usernames and passwords, or credentials in an ssh/scp-style way.  Then I decided that I wanted to be able to store URI's as well, since a username and password is only used in the context of where those are to be used, but then had to consider contending with the same sort of mucking about as I did with git-boot.  This was begun as an exploratory exercise in programming a more satisfying and general solution inside the currently being used version of Secrets for its use there and elsewhere, and so was summarily ejected.  

# Examples: 

# URI should handle 
# of what kinds of URI/ssh strings this will handle
# hostname
# user@hostname
# user:password@hostname
# scheme://hostname
# scheme://hostname/path
# scheme://hostname:/path
# scheme://user@hostname
# scheme://user:password@hostname
# scheme://user@hostname/path
# scheme://user@hostname:/path
# scheme://user:password@hostname/path
# scheme://user:password@hostname:/path

# hostname:port
# user@hostname:port
# user:password@hostname:port
# scheme://hostname:port
# scheme://hostname:port/path
# scheme://hostname:port:/path
# scheme://user@hostname:port
# scheme://user:password@hostname:port
# scheme://user@hostname:port/path
# scheme://user@hostname:port:/path
# scheme://user:password@hostname:port/path
# scheme://user:password@hostname:port:/path

# Todo: 
# 1. Handle port numbers.  Done as of 0.1.0.  
# 2. Create strict and non-strict parsing modes, which will either accept or reject non-URI ssh/scp formatted strings if they are supplied.  

# Changes since 0.0: 
# (It now handles port numbers and a few fixes.)
# 1. ~ URI.protocol.  
# 2. + URI.port_number
# 3. + URI.hostname_and_port_number.  
# 4. + URI.has_port_number?.  
# 5. ~ URI.protocol_with_separator.  
# 6. ~ URI.has_colon_path_separator.  
# 7. + URI#credentials.  
# 8. + URI#port_number.  
# 9. + a bunch of alias_methods for new and existing methods.  

require 'Module/alias_methods'
require 'Array/all_but_first'
require '_meta/blankQ'

class URI
  
  class << self
    
    def parse(uri)
      URI.new(uri)
    end
    
    def protocol(uri)
      if has_protocol?(uri)
        uri.split('://').first
      else
        nil
      end
    end
    alias_methods :scheme, :protocol
    
    def credentials(uri)
      if has_credentials?(uri)
        all_but_protocol(uri).split('@').first
      else
        nil
      end
    end
    alias_methods :username_and_password, :credentials
    alias_methods :userinfo, :credentials
    
    def username(uri)
      if has_credentials?(uri)
        credentials(uri).split(':')[0]
      else
        nil
      end
    end
    alias_methods :user, :username
    
    def password(uri)
      if has_credentials?(uri)
        credentials(uri).split(':')[1]
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
    
    def hostname_and_path(uri)
      if has_credentials?(uri)
        uri.split('@').last
      else
        all_but_protocol(uri)
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
    
    def has_credentials?(uri)
      uri.match(/@/) ? true : false
    end
    alias_methods :has_username_and_password?, :has_credentials?
    
    def has_protocol?(uri)
      uri.match(/^[a-z]*?:\/\//) ? true : false
    end
    alias_methods :has_scheme?, :has_protocol?
    
    def has_colon_path_separator?(uri)
      hostname_and_path(uri).match(/:\//) ? true : false
    end
    alias_methods :uses_colon_path_separator?, :has_colon_path_separator?
    
    def has_port_number?(uri)
      hostname_and_path(uri).match(/(:\d+\/)|(:\d+$)/) ? true : false
    end
    alias_methods :has_port?, :has_port_number?
    
    def all_but_protocol(uri)
      uri.split('://').last
    end
    
    def all_but_credentials(uri)
      if has_protocol?(uri)
        "#{protocol_with_separator(uri)}#{hostname_and_path(uri)}"
      else
        hostname_and_path(uri)
      end
    end
    
    def protocol_with_separator(uri)
      protocol(uri).blank? ? '' : "#{protocol(uri)}://"
    end
    
    def username_and_password_with_separator(uri)
      if username(uri).blank?
        ''
      elsif password(uri).blank?
        "#{username(uri)}@"
      else
        "#{username(uri)}:#{password(uri)}@"
      end
    end
    
  end # class << self
  
  def initialize(uri = nil)
    @uri = uri
  end
  
  def protocol
    @protocol ||= self.class.protocol(@uri)
  end
  alias_methods :scheme, :protocol
  
  def credentials
    @credentials ||= self.class.credentials(@uri)
  end
  
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
  
  def protocol_with_separator
    self.class.protocol_with_separator(@uri)
  end
  
  def username_and_password_with_separator
    self.class.username_and_password_with_separator(@uri)
  end
  
  def to_s(use_colon = false)
    if use_colon
      "#{protocol_with_separator}#{username_and_password_with_separator}#{hostname}:#{path}"
    else
      "#{protocol_with_separator}#{username_and_password_with_separator}#{hostname}#{path}"
    end
  end
  
end
