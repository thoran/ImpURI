# ImpURI.rb

# 20140509
# 0.6.3

# Description: A cleaner and simpler URI and ssh/scp resource parser for Ruby.

# Todo:
# 1. Handle port numbers.  Done as of 0.1.0.
# 2. Create strict and non-strict parsing modes, which will either accept or reject non-URI ssh/scp formatted strings if they are supplied.  Done as of 0.2.0.
# 3. Doesn't handle some of the funkier URI's like: ssh:// with keys in the userinfo section, mailto: (no ://, but merely :), and ldap://.
# 4. Consider encoding everything in the URI before breaking down the strings, so as to avoid the kind of complexity introduced in ImpURI.has_userinfo?().

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
# 0/1
# 32. ~ ImpURI.has_userinfo?(), so as it may have '@' within the credential strings.
# 33. ~ ImpURI.parameters(), so as it is a little tighter and faster by swapping out each() for inject().
# 1/2
# 34. ~ lib/ImpURI.rb, moved everything to lib/ImpURI.rbd/ImpURI.rb, and added a require line pointing to where everything was moved.
# 35. ~ ImpURI.has_user_info?(), so as it can cope better with ssh-style strings.
# 36. ~ ImpURI.has_colon_path_separator?(), so as it can handle ssh-style strings with a ~ as the first character after the :.
# 37. ~ ImpURI.is_ssh?(), but commented out, presumably because it wasn't used.
# 2/3: Improved handling of ssh-style strings both generally and as per Github specifically, and greatly expanded test coverage.
# 38. /minitest/test/.
# 39. Moved the specs from test to test/ImpURI.
# 40. ~ test/ImpURI/instance_methods.rb, by way of adding a lot more specs.
# 41. Added a number of aliases which aren't preceded by has_...? for those methods which do.
# 42. Uncommented ImpURI.is_ssh?().
# 43. Added a complementary ImpURI#is_ssh().
# 44. Moved all the library comments to lib/ImpURI.rb (ie. here) from lib/ImpURI.rbd/ImpURI.rb.
# 45. Removed all the trailing spaces from all files.
# 46. ~ ImpURI.userinfo(), so that it can cope with ssh-style strings, which have no password component.
# 47. + ImpURI.has_username?(), in support of the change to ImpURI.userinfo() immediately above.
# 48. ~ ImpURI.has_userinfo(), so that it correctly identifies those strings which have only username and password and not those with usernames as well.
# 49. ~ ImpURI.has_colon_path_separator?() so that it more generally is able to identify colon separated paths, particularly prompted by those for Github.
# 50. ~ ImpURI.hostname_and_path(), so that it too is able to cope with the change to has_userinfo?() being more specific about accepting only those URI's with usernames and passwords.
# 51. ~ ImpURI.request_uri(), so that it works for ssh-style strings as well, though given that this is for compatibility with URI I'm not sure how useful that is...
# 52. ~ ImpURI.username(), so that it correctly returns only a username when presented with an ssh-style string.

require 'ImpURI.rbd/ImpURI'
