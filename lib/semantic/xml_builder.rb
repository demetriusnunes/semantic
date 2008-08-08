class XmlBuilder
  
  def initialize(opts = {})
    @prefix = opts[:prefix]
  end
  
  def method_missing(sym, *args, &block)
    buf = ""
    inner = ""
    
    buf << "<"
    buf << "#{@prefix}:" if @prefix
    buf << "#{sym}"
    
    for arg in args
      if arg.is_a? Hash
        buf << " "
        buf << arg.inject([]) { |s,kv| s << "#{kv.first}=\"#{kv.last}\"" }.join(" ")
      end
    end

    inner << args.first if args.first.is_a?(String)
    inner << block.call.to_s if block
    
    if inner.size > 0
      buf << ">" << inner << "</#{@prefix}:#{sym}>"
    else
      buf << "/>"
    end
  end
end

module Kernel
  
  @@xml_builders = {}
  def xml_builder(opts = nil)
    opts ? @@xml_builders[self] = XmlBuilder.new(opts) : @@xml_builders[self]
  end
  
end