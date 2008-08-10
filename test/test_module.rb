require File.join(File.dirname(__FILE__), 'test_helper')

class TestModule < Test::Unit::TestCase
  
  context "A Module" do
    
    should "allow namespace definition for all classes within the module" do
      assert_nothing_raised {  
        Object.module_eval do
          module A
            namespace "temp1" => "http://temp-uri/a"
            class C; end
            class E; end
          end
          module B
            namespace "temp2" => "http://temp-uri/b"
            class D; end
            class F; end
          end
        end
      }
      
      assert_equal("http://temp-uri/a", A.namespace.uri)
      assert_equal("http://temp-uri/a", A::C.namespace.uri)
      assert_equal("http://temp-uri/a", A::E.namespace.uri)
      assert_equal("http://temp-uri/b", B.namespace.uri)
      assert_equal("http://temp-uri/b", B::D.namespace.uri)
      assert_equal("http://temp-uri/b", B::F.namespace.uri)
    end
    
    should "allow namespace to be overriden by modules within a module" do
      assert_nothing_raised {  
        Object.module_eval do
          module A
            namespace "temp-a" => "http://temp-uri/a"
            
            module B
              namespace "temp-b" => "http://temp-uri/b"
              class D; end
            end
            
            class C; end
          end
        end
      }
      
      assert_equal("http://temp-uri/a", A.namespace.uri)
      assert_equal("http://temp-uri/a", A::C.namespace.uri)
      assert_equal("http://temp-uri/b", A::B.namespace.uri)
      assert_equal("http://temp-uri/b", A::B::D.namespace.uri)
    end
    
  end

end
