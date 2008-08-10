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
    
  end
end
