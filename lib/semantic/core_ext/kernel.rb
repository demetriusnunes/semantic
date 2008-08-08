module Kernel

  @@namespaces = {}
  def namespace(uri = nil)
    uri ? set_namespace(self, uri) : find_namespace(self)
  end

  def container
  end

  private
  
  def set_namespace(klass, uri)
    @@namespaces[klass] = uri
  end
  
  def find_namespace(klass)
    parts = klass.name.split("::")
    modules = []
    parts.each_with_index { |p,i| modules << parts[0,i+1].join("::") }
    modules.reverse.each { |mod| 
      ns = @@namespaces[mod.constantize]  
      return ns if ns
    }
    nil
  end

end
