# String#blank?
# String#blankQ

# 2010.04.04
# 0.0.1

# History: Stolen wholesale from a recent version of ActiveSupport.  

# Changes: 
# 1. Now using a more recent version from ActiveSupport.  This more recent version from ActiveSupport is likely more efficient and slightly more succinct.  

class String
  
  def blank?
    self !~ /\S/
  end
  
end
