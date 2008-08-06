require File.join(File.dirname(__FILE__), 'test_helper')

class TestProperty < Test::Unit::TestCase
  
  context "A Property" do
    should "have comments" do
      p = property :name do
        comment "A name property"
      end
      
      assert_equal("A name property", p.comment)
    end
  end
end