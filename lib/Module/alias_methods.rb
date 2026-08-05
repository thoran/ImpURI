# Module#alias_methods

# 20080831
# 0.0.0

# Description: I have a penchance for having multiple method names and having line after line of alias_method calls is kinda ugly.  

require 'Array/all_but_last'

class Module
  
  def alias_methods(*args)
    args.all_but_last.each{|e| alias_method e.to_sym, args.last.to_sym}
  end
  
end
