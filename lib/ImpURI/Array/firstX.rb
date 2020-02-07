# Array#first!
# 20060630
#
# Description: Sometimes it makes more sense to treat arrays this way.  
#
# Discussion: This and last! were taken from Skink2Quick from a few months ago.  

class Array
  alias_method :first!, :shift
end
