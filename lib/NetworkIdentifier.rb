# NetworkIdentifier

# 2010.05.08
# 0.0.0

# History: I've run into circumstances, such as when writing git-boot, where I can't use Ruby's standard library URI class to parse ssh/scp-style network resources.  Similarly, I have recently written a class called Secrets as a way of storing usernames and passwords, or credentials in an ssh/scp-style way.  Then I decided that I wanted to be able to store URI's as well, since a username and password is only used in the context of where those are to be used, but then had to consider contending with the same sort of mucking about as I did with git-boot.  This was begun as an exploratory exercise in programming a more satisfying and general solution inside the currently being used version of Secrets for its use there and elsewhere, and so was summarily ejected.  

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

# URIs & ssh
class NetworkIdentifier
  
  class << self
    
    def parse(uri)
      URI.new(uri)
    end
    
    def protocol(uri)
      uri.split('://').first
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
    alias_methods :passwd, :password
    
    def hostname(uri)
      hostname_and_path(uri).split('/').first.split(':').first
    end
    alias_methods :host, :hostname
    
    def path(uri)
      hostname_and_path(uri).split('/').all_but_first.join('/')
    end
    
    def hostname_and_path(uri)
      if has_credentials?(uri)
        uri.split('@').last
      else
        all_but_protocol(uri)
      end
    end
    alias_methods :host_and_path
    
    def has_credentials?(uri)
      uri.match(/@/) ? true : false
    end
    alias_methods :has_username_and_password?, :has_credentials?
    
    def has_protocol?(uri)
      uri.match(/^[a-z]*?:\/\//) ? true : false
    end
    alias_methods :has_scheme?, :has_protocol?
    
    def has_colon_path_separator?(uri)
      hostname_and_path(uri).match(/:/) ? true : false
    end
    alias_method :uses_colon_path_separator?, :has_colon_path_separator?
    
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
      protocol(uri).blank? ? '' : "#{protocol}://"
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
  
  def username
    @username ||= self.class.username(@uri)
  end
  alias_methods :user, :username
  
  def password
    @password ||= self.class.password(@uri)
  end
  alias_methods :passwd, :password
  
  def hostname
    @hostname ||= self.class.hostname(@uri)
  end
  alias_methods :host, :hostname
  
  def path
    @path ||= self.class.path(@url)
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
