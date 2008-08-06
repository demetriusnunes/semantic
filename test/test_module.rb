require File.join(File.dirname(__FILE__), 'test_helper')

class TestModule < Test::Unit::TestCase
  
  context "A Module" do
    
    should "allow namespace definition for all classes within the module" do
      assert_nothing_raised {  
        Object.module_eval do
          module A
            namespace "http://temp-uri/a"
            class C; end
            class E; end
          end
          module B
            namespace "http://temp-uri/b"
            class D; end
            class F; end
          end
        end
      }
      
      assert_equal("http://temp-uri/a", A.namespace)
      assert_equal("http://temp-uri/a", A::C.namespace)
      assert_equal("http://temp-uri/a", A::E.namespace)
      assert_equal("http://temp-uri/b", B.namespace)
      assert_equal("http://temp-uri/b", B::D.namespace)
      assert_equal("http://temp-uri/b", B::F.namespace)
    end
    
    should "allow namespace to be overriden by modules within a module" do
      assert_nothing_raised {  
        Object.module_eval do
          module A
            namespace "http://temp-uri/a"
            
            module B
              namespace "http://temp-uri/b"
              class D; end
            end
            
            class C; end
          end
        end
      }
      
      assert_equal("http://temp-uri/a", A.namespace)
      assert_equal("http://temp-uri/a", A::C.namespace)
      assert_equal("http://temp-uri/b", A::B.namespace)
      assert_equal("http://temp-uri/b", A::B::D.namespace)
    end
    
  end

end