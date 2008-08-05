module Rdfs

  class Resource
  
    # class methods
    class << self
      
      def comment(str)
        str ? @comment = str : @comment
      end      
      
      def property(sym, opts = {}, &block)
        Object.property(sym, opts.merge(:domain => self), &block)
      end
      
    end

    # instance methods
        
    def initialize(id, &block)
      @id = id
      block.call(self) if block
    end

    def to_xml
    end
    
  end
end
