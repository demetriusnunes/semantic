module Rdfs
  module Class
    def uri
      @uri ||= Uri.join(namespace.uri, name.demodulize)
    end
    
    def to_xml
      Rdfs::Resource.xml_builder.Class("rdf:ID" => name.demodulize) { |xml|
        xml << comment.to_xml if comment
        xml.subClassOf("rdf:resource" => superclass.uri)
      }
    end    
  end
end

class Class
  include Rdfs::Class
end
