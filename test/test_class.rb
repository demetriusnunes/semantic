require File.join(File.dirname(__FILE__), 'test_helper')

class TestClass  < Test::Unit::TestCase
  context "A Rdfs::Class" do
  
    setup do 
      @classes = [ Rdfs::Resource, Rdf::Property, Rdfs::Container ]
    end
    
    should "make Class respond to #to_xml" do
      assert Class.respond_to?(:to_xml)
    end
    
    should "respond to #to_xml" do
      assert @classes.all? { |klass| klass.respond_to?(:to_xml) }
    end
    
    should "make all classes respond true to #is_a? Rdfs::Class" do
      assert @classes.all? { |klass| klass.is_a? Rdfs::Class }
    end
  end
end
