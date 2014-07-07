# ImpURI.rb

# 20140707
# 0.7.0

# Description: A cleaner and simpler URI and ssh/scp resource parser for Ruby.  Though I'm not sure about the simpler bit anymore.  It's now over 500 lines you know!

# Todo:
# 1. Handle port numbers.  Done as of 0.1.0.
# 2. Create strict and non-strict parsing modes, which will either accept or reject non-URI ssh/scp formatted strings if they are supplied.  Done as of 0.2.0.
# 3. Doesn't handle some of the funkier URI's like: ssh:// with keys in the userinfo section, mailto: (no ://, but merely :), and ldap://.
# 4. Consider encoding everything in the URI before breaking down the strings, so as to avoid the kind of complexity introduced in ImpURI.has_userinfo?().
# 5. Be able to change the semicolon parameter separator for an ImpURI instance.
# 6. Be able to change the colon path separator for an ImpURI instance, say if converting from ssh-form to the URI-form of an ssh resource for instance.  Any other uses?

# Changes since 0.6:
# 0: Enable assignment of values to component parts.
# 1. + #scheme=.
# 2. + #username=.
# 3. + #password=.
# 4. + #hostname=.
# 5. + #port_number=.
# 6. + #path=.
# 7. + #parameter_string=.
# 8. + #parameters=.
# 9. + #request_uri=.
# 10. + require 'Hash/x_www_form_urlencode'.
# 11. ~ self.has_username?, so that it works more correctly.
# 12. ~ #scheme_with_separator, so that it is defined in terms of it's component parts, rather than making use of the class methods.
# 13. ~ #userinfo, so that it is defined in terms of it's component parts, rather than making use of the class methods.
# 14. ~ #userinfo_with_separator, so that it is defined in terms of it's component parts, rather than making use of the class methods.
# 15. ~ #hostname_optionally_with_port_number, so that it is defined in terms of it's component parts, rather than making use of the class methods.
# 16. ~ #hostname_and_path, so that it is defined in terms of it's component parts, rather than making use of the class methods.
# 17. ~ #hostname_and_port_number, so that it is defined in terms of it's component parts, rather than making use of the class methods.
# 18. ~ #all_but_scheme, so that it is defined in terms of it's component parts, rather than making use of the class methods.
# 19. ~ #to_s, so that it is defined in terms of it's component parts, rather than making use of the class methods.
# 20. ~ #to_h, so that it includes parameter_string.
# 21. ~ #to_s, so that it makes use of #all_but_scheme, and includes parameter_string.
# 22. + alias_methods for #has_semicolon_parameter_separator?.
# 23. + alias #ssh? for #is_ssh?.
# 24. ~ #has_scheme?, so that it tests the local component value, rather than using the corresponding class method.
# 25. ~ #has_port_number?, so that it tests the local component value, rather than using the corresponding class method.
# 26. ~ #has_parameters?, so that it tests the local component value, rather than using the corresponding class method.
# 27. + #has_username?.
# 28. + #has_password?.
# 29. + #has_hostname?.
# 30. + #has_path?.
# 31. + #has_parameter_string?.
# 32. + #hostname_optionally_with_port_number, for use in #all_but_scheme.

require 'ImpURI.rbd/ImpURI'
