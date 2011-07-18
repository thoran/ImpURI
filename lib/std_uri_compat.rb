module URI
  
  class HTTP
    
    def initialize(*args, &block)
      @uri = URI.new(*args, &block)
    end
    
    def method_missing(method_name, *args, &block)
      @uri.send(method_name, *args, &block)
    end
    
  end
  
end
