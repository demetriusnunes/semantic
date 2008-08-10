class XmlBuilder
  
  def initialize(opts = {})
    @prefix = opts[:prefix] if opts
    @prefix ||= ""
  end
  
  def <<(value)
    @inner << value
    nil # so this doesnt get added twice if this is the last statement in block
  end
  
  def method_missing(sym, *args, &block)
    buf = ""; @inner = ""
    __write_opening_tag__(buf, sym)
    __write_attributes__(buf, *args)    
    __write_inner_content__(buf, *args, &block)
    __write_closing_tag__(buf, sym)
    @inner = ""
    buf
  end

  def __write_opening_tag__(buf, sym)
    buf << "<"
    buf << "#{@prefix}:" unless @prefix.empty?
    buf << "#{sym}"
  end
    
  def __write_inner_content__(buf, *args, &block)
    @inner << args.first if args.first.is_a?(String)
    @inner << block.call(self.clone).to_s if block
    if @inner.size > 0
      buf << ">" << @inner 
    end
  end
  
  def __write_attributes__(buf, *args)
    args.each do |arg|
      if arg.is_a? Hash
        buf << " "
        buf << arg.inject([]) { |s,kv| s << "#{kv.first}=\"#{kv.last}\"" }.join(" ")
      end
    end
  end
  
  def __write_closing_tag__(buf, sym)
    if @inner.size > 0
      buf << "</"
      buf << "#{@prefix}:" if @prefix
      buf << "#{sym}>"
    else
      buf << "/>"
    end
  end
end

class Class
  def xml_builder(opts = nil)
    builder = get_module_property(:xml_builder)
    if opts.is_a?(Hash) || builder.nil?
      opts ||= {}
      opts.merge!(:prefix => self.namespace.prefix) if opts && self.namespace 
      builder = set_module_property(:xml_builder, XmlBuilder.new(opts))
    end
    builder
  end    
end

class Object
  def xml_builder; self.class.xml_builder end
end

