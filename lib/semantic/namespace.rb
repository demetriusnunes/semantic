class Namespace
  attr_reader :prefix, :uri
  
  def initialize(prefix, uri)
    @prefix = prefix
    @uri = uri
  end
  
end

module Kernel
  def namespace(kv = nil)
    if kv.is_a?(String)
      set_module_property(:namespace, Namespace.new(nil, kv))
    elsif kv.is_a?(Hash)
      set_module_property(:namespace, Namespace.new(*kv.to_a.flatten))
    else
      get_module_property(:namespace)
    end
  end
end
