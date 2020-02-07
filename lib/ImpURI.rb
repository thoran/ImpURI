# ImpURI.rb
# ImpURI

# 20200207
# 0.8.0

# Description: A cleaner and simpler URI and ssh/scp resource parser for Ruby.  Though I'm not sure about the simpler bit anymore.  It's now over 500 lines you know!

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require '_meta/blankQ'
require 'Array/all_but_first'
require 'Array/all_but_last'
require 'Array/extract_optionsX'
require 'Hash/x_www_form_urlencode'
require 'Module/alias_methods'

require 'ImpURI/VERSION'

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
      elsif has_username?(uri)
        uri.split('@').first
      else
        nil
      end
    end
    alias_methods :credentials, :username_and_password, :user_info, :userinfo

    def username(uri)
      if has_userinfo?(uri)
        userinfo(uri).split(':')[0]
      elsif has_username?(uri)
        uri.split('@').first
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

    # For the instance method providing compatibility to Ruby's URI.
    def request_uri(uri)
      if has_colon_path_separator?(uri)
        path = hostname_and_path(uri).split(':').all_but_first.join('/')
      else
        path = hostname_and_path(uri).split('/').all_but_first.join('/')
        path.blank? ? nil : '/' + path
      end
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
        parameter_parts = (
          case parameter_separator(uri)
          when '&'; non_nil_parameter_string.split('&')
          when ';'; non_nil_parameter_string.split(';')
          else [non_nil_parameter_string]
          end
        )
        parameter_parts.inject({}) do |h,pairs|
          a = pairs.split('=')
          h[a[0]] = a[1]
          h
        end
      else
        nil
      end
    end
    alias_methods :query, :parameters

    def hostname_and_path(uri)
      if has_userinfo?(uri) || has_username?(uri)
        if all_but_scheme(uri).split('@').size > 1
          all_but_scheme(uri).split('@').all_but_first.join('@')
        else
          all_but_scheme(uri).split('@').first
        end
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
      if has_scheme?(uri)
        partial_decomposition = uri.split('//').all_but_first.join.split('/')
        if partial_decomposition.size > 1
          next_decomposition = partial_decomposition.all_but_last
        else
          next_decomposition = [partial_decomposition.first]
        end
        next_decomposition.join('/').match(/@/) ? true : false
      else
        uri.match(/.+:.+@/) ? true : false
      end
    end
    alias_methods :credentials?, :username_and_password?, :user_info?, :userinfo?, :has_credentials?, :has_username_and_password?, :has_user_info?, :has_userinfo?

    def has_username?(uri)
      if has_scheme?(uri)
        all_but_scheme(uri).scan('@').first ? true : false
      else
        uri.scan('@').first ? true : false
      end
    end

    def has_scheme?(uri)
      uri.match(/^[a-z]*?:\/\//) ? true : false
    end
    alias_methods :protocol?, :scheme_name?, :scheme?, :has_protocol?, :has_scheme_name?, :has_scheme?

    def has_colon_path_separator?(uri)
      hostname_and_path(uri).match(/:/) && !has_port_number?(uri) ? true : false
    end
    alias_methods :colon_path_separator?, :uses_colon_path_separator?, :has_colon_path_separator?

    def has_port_number?(uri)
      hostname_and_path(uri).match(/:\d+/) ? true : false
    end
    alias_methods :port?, :portnumber?, :port_number?, :has_port?, :has_portnumber?, :has_port_number?

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

    def is_ssh?(uri)
      !has_scheme?(uri) && has_colon_path_separator?(uri) ? true : false
    end

  end # class << self

  def initialize(uri, *args)
    options = args.extract_options!
    if options[:strict]
      raise SchemeMissingError if !ImpURI.has_scheme?(uri)
      raise ColonPathSeparatorsNotAllowedError if ImpURI.has_colon_path_separator?(uri)
    end
    @uri = uri
  end

  # attributes

  def scheme
    @scheme ||= ImpURI.scheme(@uri)
  end
  alias_methods :protocol, :scheme_name, :scheme

  def scheme=(new_scheme)
    @scheme = new_scheme
    @uri = to_s
  end
  alias_methods :protocol=, :scheme_name=, :scheme=

  def username
    @username ||= ImpURI.username(@uri)
  end
  alias_methods :user, :username

  def username=(new_username)
    @username = new_username
    @uri = to_s
  end
  alias_methods :user=, :username=

  def password
    @password ||= ImpURI.password(@uri)
  end
  alias_methods :pass, :passwd, :password

  def password=(new_password)
    @password = new_password
    @uri = to_s
  end
  alias_methods :pass=, :passwd=, :password=

  def hostname
    @hostname ||= ImpURI.hostname(@uri)
  end
  alias_methods :host, :hostname

  def hostname=(new_hostname)
    @hostname = new_hostname
    @uri = to_s
  end
  alias_methods :host=, :hostname=

  def port_number
    @port_number ||= ImpURI.port_number(@uri)
  end
  alias_methods :port, :portnumber, :port_number

  def port_number=(new_port_number)
    @port_number = new_port_number
    @uri = to_s
  end
  alias_methods :port=, :portnumber=, :port_number=

  def path
    @path ||= ImpURI.path(@uri)
  end

  def path=(new_path)
    @path = new_path
    @uri = to_s
  end

  def parameter_string
    @parameter_string ||= ImpURI.parameter_string(@uri)
  end

  def parameter_string=(new_parameter_string)
    @parameter_string = new_parameter_string
    @uri = to_s
    @parameters = ImpURI.parameters(@uri)
  end

  def parameters
    @parameters ||= ImpURI.parameters(@uri)
  end

  def parameters=(new_parameters)
    @parameters = new_parameters
    @parameter_string = @parameters.x_www_form_urlencode
    @uri = to_s
  end

  # For compatability with Ruby's URI.  Not quite a drop-in replacement for most aspects as yet however.
  # Perhaps it should be in a compatability module and included.
  def request_uri
    @request_uri ||= ImpURI.request_uri(@uri)
  end

  # derived attributes

  def scheme_with_separator
    if scheme.blank?
      ''
    else
      "#{scheme}://"
    end
  end
  alias_methods :protocol_with_separator, :scheme_with_separator

  def userinfo
    if password
      "#{username}:#{password}"
    else
      "#{username}"
    end
  end
  alias_methods :credentials, :username_and_password, :user_info, :userinfo

  def userinfo_with_separator
    if username.blank?
      ''
    elsif password.blank?
      "#{username}@"
    else
      "#{username}:#{password}@"
    end
  end
  alias_methods :credentials_with_separator, :username_and_password_with_separator, :user_info_with_separator, :userinfo_with_separator

  def hostname_optionally_with_port_number
    if has_port_number?
      "#{hostname}:#{port_number}"
    else
      "#{hostname}"
    end
  end
  alias_methods :hostname_optionally_with_portnumber, :hostname_optionally_with_port_number

  def hostname_and_path
    if has_colon_path_separator?
      "#{hostname}:#{path}"
    else
      "#{hostname}#{path}"
    end
  end

  def hostname_and_port_number
    if has_colon_path_separator?
      hostname_and_path.split(':').all_but_last.join(':')
    else
      hostname_and_path.split('/').first
    end
  end

  def all_but_scheme
    if has_colon_path_separator?
      "#{userinfo_with_separator}#{hostname_optionally_with_port_number}:#{path}"
    else
      "#{userinfo_with_separator}#{hostname_optionally_with_port_number}#{path}"
    end
  end

  def to_s
    if has_parameter_string?
      "#{scheme_with_separator}#{all_but_scheme}?#{parameter_string}"
    else
      "#{scheme_with_separator}#{all_but_scheme}"
    end
  end

  def to_h
    {scheme: scheme, username: username, password: password, hostname: hostname, port_number: port_number, path: path, parameter_string: parameter_string}
  end

  # attribute boolean methods

  def has_scheme?
    scheme.nil? ? false : true
  end
  alias_methods :protocol?, :scheme_name?, :scheme?, :has_protocol?, :has_scheme_name?, :has_scheme?

  def has_username?
    username.nil? ? false : true
  end
  alias_methods :user?, :username?, :has_user?, :has_username?

  def has_password?
    password.nil? ? false : true
  end
  alias_methods :pass?, :passwd?, :password?, :has_pass?, :has_passwd?, :has_password?

  def has_hostname?
    hostname.nil? ? false : true
  end
  alias_methods :host?, :hostname?, :has_host?, :has_hostname?

  def has_port_number?
    port_number.nil? ? false : true
  end
  alias_methods :port?, :portnumber?, :port_number?, :has_port?, :has_portnumber?, :has_port_number?

  def has_path?
    path.nil? ? false : true
  end
  alias_methods :path?, :has_path?

  def has_parameter_string?
    parameter_string.nil? ? false : true
  end
  alias_methods :parameter_string?, :has_get_parameter_string?, :has_parameter_string?

  def has_parameters?
    parameters.nil? ? false : true
  end
  alias_methods :parameters?, :has_get_parameters?, :has_parameters?

  # derived attribute boolean methods

  def has_userinfo?
    ImpURI.has_userinfo?(@uri)
  end
  alias_methods :credentials?, :username_and_password?, :user_info?, :userinfo?, :has_credentials?, :has_username_and_password?, :has_user_info?, :has_userinfo?

  def has_colon_path_separator?
    ImpURI.has_colon_path_separator?(@uri)
  end
  alias_methods :colon_path_separator?, :uses_colon_path_separator?, :has_colon_path_separator?

  def has_semicolon_parameter_separator?
    ImpURI.has_semicolon_parameter_separator?(@uri)
  end
  alias_methods :semicolon_query_separator?, :semicolon_parameter_separator?, :has_semicolon_parameter_separator?
  alias_methods :uses_semicolon_query_separator?, :uses_semicolon_parameter_separator?, :has_semicolon_parameter_separator?
  alias_methods :has_semicolon_query_separator?, :has_semicolon_parameter_separator?

  def has_ampersand_parameter_separator?
    ImpURI.has_ampersand_parameter_separator?(@uri)
  end
  alias_methods :has_ampersand_query_separator?, :has_ampersand_parameter_separator?

  def is_ssh?
    ImpURI.is_ssh?(to_s)
  end
  alias_methods :ssh?, :is_ssh?

end
