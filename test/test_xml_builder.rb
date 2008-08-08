require File.join(File.dirname(__FILE__), 'test_helper')

class TestXmlBuilder < Test::Unit::TestCase
  
  context "A XmlBuilder" do
    setup do
      @builder = XmlBuilder.new(:prefix => "temp")
    end
    
    should "output an empty value" do
      assert_equal "<temp:comment/>", @builder.comment
    end

    should "output an inner value from argument" do
      assert_equal "<temp:comment>hello</temp:comment>", @builder.comment("hello")
    end

    should "output an inner value from block" do
      assert_equal "<temp:comment>hello</temp:comment>", @builder.comment { "hello" }
    end
    
    should "output an empty value with attributes" do
      assert_equal "<temp:comment attr1=\"value1\" attr2=\"value2\"/>", 
        @builder.comment("attr1" => "value1", "attr2" => "value2")
    end

    should "output an inner value with attributes from block" do
      assert_equal "<temp:comment attr1=\"value1\">hello</temp:comment>", 
        @builder.comment("attr1" => "value1") { "hello" }
    end

    should "output an inner value with attributes from argument" do
      assert_equal "<temp:comment attr1=\"value1\">hello</temp:comment>", 
        @builder.comment("hello", "attr1" => "value1")
    end
  end
  
end