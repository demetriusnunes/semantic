require File.join(File.dirname(__FILE__), 'test_helper')

class TestResource < Test::Unit::TestCase
  
  context "A Rdfs::Resource" do
    
    setup do
      assert_nothing_raised {
        Object.module_eval do
          class SampleResource < Rdfs::Resource
            namespace "http://temp-uri/sampleresource"
            comment "This is a sample resource"
            property :name, :range => Rdf::Literal
            property :list, :range => Rdf::Seq
          end
        end
      }
    end
    
    should "have a specific namespace" do
      assert_equal("http://www.w3.org/2000/01/rdf-schema#", Rdfs::Resource.namespace)
    end
    
    should "have a comment macro" do
      assert_equal("This is a sample resource", SampleResource.comment.to_s)
    end
    
    should "be assigned an auto-generated uri composed of namespace+uuid if none given" do
      sr = SampleResource.new
      assert(sr.uri =~ Regexp.new("#{sr.class.namespace}\/[0-9|a-f]{32}"))
    end

    should "have an uri composed of its namespace + a give id" do
      sr = SampleResource.new("sample1")
      assert(sr.uri =~ Regexp.new("#{sr.class.namespace}\/sample1"))
    end

    should "be initialized within a block" do
      assert_nothing_raised { create_sample_resource }
      assert_equal(SampleResource, @resource.class)
      assert_equal("http://temp-uri/sampleresource/sample2", @resource.uri)
      assert_equal(@resource_id, @resource.__id__)
    end
    
    should "have its properties set correctly" do
      create_sample_resource
      assert_equal("Sample", @resource.name)
      assert_kind_of(Array, @resource.list)
      assert_equal(2, @resource.list.size)
      assert(@resource.list.include?("a"))
      assert(@resource.list.include?("b"))
    end
  end
  
  private
  def create_sample_resource
    @resource_id = nil
    @resource = SampleResource.new("sample2") do |sr|
      sr.name = "Sample"
      sr.list << "a"
      sr.list << "b"
      @resource_id = sr.__id__
    end
  end
  
end