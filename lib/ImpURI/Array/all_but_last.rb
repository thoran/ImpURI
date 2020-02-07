# Array#all_but_last

# 20080831
# 0.1.0

# Description: This returns a copy of the receiving array with the last element removed.  

# Changes since 0.0: 
# 1. I've added require 'Array/lastX', since I think it is reasonable that each file should load its own dependencies.  

# Todo: 
# 1. Conditionally do the require depending on whether the method already exists on Array and/or on whether rubylib has been defined elsewhere, since the require will fail in either case; and if rubylib is available, but this method isn't.  

require 'Array/lastX'

class Array
  
  def all_but_last
    d = self.dup
    d.last!
    d
  end
  
end
