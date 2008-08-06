module Kernel

  @@properties = {}
  def property(sym, opts = {}, &block)
    @@properties[sym] = Rdfs::Property.new(sym, opts, &block)
  end
    
  def list_accessor(*args)
    for arg in args
      module_eval do
        define_method arg do
         instance_variable_set("@#{arg}", []) unless instance_variable_defined?("@#{arg}")
         instance_variable_get("@#{arg}")
        end
      end
    end
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
        domain.module_eval { attr_accessor sym }
      end
      
      if @range.flatten.compact.any? { |r| r == Rdf::Seq }
        @domain.flatten.compact.each do |domain|
          domain.module_eval { list_accessor sym }
        end
      end
      
      self
    end

    def comment(str = nil)
      str ? @comment = str : @comment
    end
    
    def domain(arr)
      @domain << arr
    end    
    
    def range(arr)
      @range << arr
    end
  end
  
end
