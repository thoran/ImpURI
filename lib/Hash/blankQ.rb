# Hash#blank?
# Hash#blankQ

# 20100308
# 0.0.0

# History: Stolen wholesale from ActiveSupport.  

class Hash
  
  alias_method :blank?, :empty?
  
end
