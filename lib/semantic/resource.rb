module Rdfs

  class Resource
    attr_accessor :uri
    
    # class methods
    class << self
      
      def comment(str = nil)
        str ? @comment = str : @comment
      end      
      
      def property(sym, opts = {}, &block)
        Object.property(sym, opts.merge(:domain => self), &block)
      end
      
    end

    # instance methods
        
    def initialize(id = nil, &block)
      @uri = File.join(self.class.namespace, id || UUID.generate!)
      block.call(self) if block
    end

    def to_xml
    end
    
  end
end
