module Kernel

  @@properties = {}
  def property(sym, opts = {}, &block)
    @@properties[sym] = Rdfs::Property.new(sym, opts, &block)
  end
    
end

module Rdfs
  
  class Property
  
    attr_accessor :range, :domain
    
    def initialize(sym, opts = {}, &block)
      @domain = []
      @range = []
      self.instance_eval(&block) if block

      range opts[:range] if opts[:range]
      domain opts[:domain] if opts[:domain]
      
      @domain.flatten.compact.each do |domain|
        domain.module_eval do
          define_method sym do
          end
          
          define_method "#{sym}=" do |value|
          end
        end
      end
      
      if @range.flatten.compact.any? { |r| r == Rdf::Seq }
        @domain.flatten.compact.each do |domain|
          domain.module_eval do
            define_method sym do
              []
            end
          end
        end
      end
      
      self
    end

    def comment(str)
      @comment = str
    end
    
    def domain(arr)
      @domain << arr
    end    
    
    def range(arr)
      @range << arr
    end
  end
  
end
