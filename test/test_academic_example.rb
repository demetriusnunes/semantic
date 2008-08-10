require File.join(File.dirname(__FILE__), 'test_helper')

class TestAcademicExample  < Test::Unit::TestCase
  require File.join(File.dirname(__FILE__), '..', 'examples', 'academic')
  
  context "In the academic example" do
    should "exist Course, Person, Student and Teacher" do
      assert(Course)
      assert(Person)
      assert(Student)
      assert(Teacher)
      assert(Student.superclass == Person)
      assert(Teacher.superclass == Person)
    end

    should "be a sample course" do
      assert($csci_2961.is_a?(Course))
    end
  end
  
end
