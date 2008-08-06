require File.join(File.dirname(__FILE__), 'test_helper')

class TestString < Test::Unit::TestCase
  
  context "A String" do
    
    should "be able to be constantized" do
      assert(!Object.const_defined?(:A))
      assert_raise(NameError) { "A".constantize }
      
      class ::A; end

      assert_nothing_raised { "A".constantize }
      assert(Object.const_defined?(:A))
    end
    
  end

end