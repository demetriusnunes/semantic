require File.join(File.dirname(__FILE__), 'test_helper')

class TestComment < Test::Unit::TestCase

  context "A comment" do
    setup do 
      @comment = Rdfs::Comment.new("Test Comment")
    end
    
    should "have a value" do
      assert_equal("Test Comment", @comment.value)
    end

    should "return the value on #to_s" do
      assert_equal(@comment.value, @comment.to_s)
    end
  
    should "output proper xml" do
      assert_equal("<rdfs:comment>Test Comment</rdfs:comment>", @comment.to_xml)
    end
  end
end  
