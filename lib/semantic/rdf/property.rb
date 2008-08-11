module Rdf
  
  class Property < Rdfs::Resource
    
    @@properties = {}
    def self.all
      @@properties
    end

    def self.for_domain(*domains)
      properties = []
      domains.each do |domain|
        properties << all.values.select { |p| p.domain.include?(domain) }
      end
      properties.flatten
    end
    
    attr_accessor :uri
    def initialize(sym, opts = {}, &block)
      @uri = Uri.join(self.class.namespace.uri, sym)
      @domain = []
      @range = []
      
      self.instance_eval(&block) if block

      range opts[:range] if opts[:range]
      domain opts[:domain] if opts[:domain]
      
      @domain.flatten.compact.each do |domain|
        domain.module_eval { attr_accessor sym }
      end
      
      if @range.flatten.compact.any? { |r| r.ancestors.include? Rdfs::Container }
        @domain.flatten.compact.each do |domain|
          domain.module_eval { list_accessor sym }
        end
      end
      
      self
    end

    def domain(arr = nil)
      arr ? @domain << arr : @domain
    end    
    
    def range(arr = nil)
      arr ? @range << arr : @range
    end
  end

end

module Kernel

  def property(sym, opts = {}, &block)
    Rdf::Property.all[sym] = Rdf::Property.new(sym, opts, &block)
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

  Rdfs::Resource.instance_eval do
    def property(sym, opts = {}, &block)
      Kernel.property(sym, opts.merge(:domain => self), &block)
    end
  end
  
end

