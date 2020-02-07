# Array#extract_options!

# 20090123
# 0.0.0

# History: Stolen wholesale from ActiveSupport.  

class Array
  
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
  
end
