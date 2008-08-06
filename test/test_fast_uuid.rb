require File.join(File.dirname(__FILE__), 'test_helper')

class TestUUID < Test::Unit::TestCase
  
  context "A fast and cheap UUID generation" do
    
    should "be possible" do
      uuid = UUID.generate!
      assert_equal(32, uuid.size)
      assert(uuid =~ /^[0-9|a-f]{32}$/)
    end

    should "should yield unique values" do
      keys = {}
      1000.times { keys[UUID.generate!] = nil }
      assert_equal(1000, keys.size)
    end
  end
end