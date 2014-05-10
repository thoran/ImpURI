# Object#blankQ
# Object#blank?

# 2010.04.04
# 0.0.1

# History: Stolen wholesale from a recent version of ActiveSupport.  

# Changes: 
# 1. Now using a more recent version from ActiveSupport.  This more recent version from ActiveSupport is likely more efficient and slightly more succinct.  

class Object
  
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
  
end
