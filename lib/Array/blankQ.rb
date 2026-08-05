# Array#blank?
# Array#blankQ

# 20100308
# 0.0.0

# History: Stolen wholesale from ActiveSupport.  

class Array
  
  alias_method :blank?, :empty?
  
end
