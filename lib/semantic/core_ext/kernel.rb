module Kernel
  
  def set_module_property(property, value, klass = self)
    class_variable_set("@@#{property}", {}) unless class_variable_defined?("@@#{property}")
    property = class_variable_get("@@#{property}")
    property[self] = value
  end
  
  def get_module_property(property, klass = self)
    parts = klass.name.split("::")
    modules = []
    parts.each_with_index { |p,i| modules << parts[0,i+1].join("::") }
    modules.reverse.each { |modstr| 
      mod = modstr.constantize
      property_var = mod.instance_eval { class_variable_get("@@#{property}") rescue nil }
      if property_var && property_value = property_var[mod]
        return property_value 
      end
    }
    nil
  end

end
