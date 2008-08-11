require File.join(File.dirname(__FILE__), 'test_helper')

class TestProperty < Test::Unit::TestCase
  
  context "A Property" do
    should "have comments" do
      p = property :name do
        comment "A name property"
      end
      
      assert_equal("A name property", p.comment.to_s)
    end
    
    should "have a specific namespace" do
      assert_equal("http://www.w3.org/1999/02/22-rdf-syntax-ns#", Rdf::Property.namespace.uri)
    end

    should "have a domain" do
      p = property :name, :domain => Rdfs::Resource
      assert_equal([Rdfs::Resource], p.domain)

      p = property :name do
        domain Rdfs::Resource
      end
      assert_equal([Rdfs::Resource], p.domain)
    end
    
    should "have a range" do
      p = property :name, :range => Rdfs::Literal
      assert_equal([Rdfs::Literal], p.range)

      p = property :name do
        range Rdfs::Literal
      end
      assert_equal([Rdfs::Literal], p.range)
    end
    
    should "be stored globally in Rdf::Property.all" do
      start_size = Rdf::Property.all.size
      assert !Rdf::Property.all.has_key?(:p1)
      p1 = property :p1, :domain => Rdfs::Resource, :range => Rdfs::Literal
      assert_equal(start_size + 1, Rdf::Property.all.size, Rdf::Property.all.inspect)
      assert Rdf::Property.all.has_key?(:p1)
      assert Rdf::Property.all.has_value?(p1)

      start_size = Rdf::Property.all.size
      assert !Rdf::Property.all.has_key?(:p2)
      p2 = property :p2, :domain => Rdfs::Resource, :range => Rdfs::Literal
      assert_equal(start_size + 1, Rdf::Property.all.size, Rdf::Property.all.inspect)
      assert Rdf::Property.all.has_key?(:p1)
      assert Rdf::Property.all.has_value?(p1)
      assert Rdf::Property.all.has_key?(:p2)
      assert Rdf::Property.all.has_value?(p2)
    end
    
    should "return properties with certain domain in Rdf::Property.for_domain" do
      Rdf::Property.all.clear
      p1 = property :p1, :domain => Rdfs::Resource, :range => Rdfs::Literal
      p2 = property :p2, :domain => Rdfs::Container, :range => Rdfs::Literal
      p3 = property :p3, :domain => Rdfs::Class, :range => Rdfs::Literal
      p4 = property :p4, :domain => Rdfs::Datatype, :range => Rdfs::Literal
      
      assert_equal([p1], Rdf::Property.for_domain(Rdfs::Resource))
      assert_equal([p2], Rdf::Property.for_domain(Rdfs::Container))
      assert_equal([p3], Rdf::Property.for_domain(Rdfs::Class))
      assert_equal([p4], Rdf::Property.for_domain(Rdfs::Datatype))

      assert_equal([p1, p2], Rdf::Property.for_domain(Rdfs::Resource, Rdfs::Container))
      assert_equal([p3, p4], Rdf::Property.for_domain(Rdfs::Class, Rdfs::Datatype))
    end
  end
end
