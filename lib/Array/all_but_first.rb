require 'Array/firstX'

class Array
  
  def all_but_first
    d = self.dup
    d.first!
    d
  end
  
end
