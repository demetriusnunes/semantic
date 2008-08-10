module Rdfs

  class Resource
    attr_accessor :uri
    
    def initialize(id = nil, &block)
      @uri = Uri.join(self.class.namespace.uri, id || UUID.generate!)
      block.call(self) if block
    end

    def xml_builder; self.class.xml_builder end
    
    def to_xml
      xml_builder.send(self.class.name.demodulize, "rdf:ID" => self.uri) {
        # add properties
      }
    end

  end
end
