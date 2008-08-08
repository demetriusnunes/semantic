module Rdfs

  class Resource
    attr_accessor :uri
    has_properties
    
    def initialize(id = nil, &block)
      @uri = File.join(self.class.namespace, id || UUID.generate!)
      block.call(self) if block
    end

    def to_xml
      xml_builder.send(self.class.name.demodulize, "rdf:ID" => self.uri) {
        
      }
    end
    
  end
end
