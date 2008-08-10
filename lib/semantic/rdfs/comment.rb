
module Rdfs

  class Comment < Rdf::Property
    attr_reader :value
    
    def initialize(str)
      @value = str
    end

    def to_s; @value end
    
    def to_xml; xml_builder.comment(@value) end
  end
  
end

comment_macro = proc do |klass, eval_method|
  klass.send(eval_method) do
    def comment str = nil
      str ? @comment = Rdfs::Comment.new(str) : @comment
    end
  end
end

comment_macro.call(Rdf::Property, :module_eval) # instance method
comment_macro.call(Rdfs::Resource, :instance_eval) # class method
