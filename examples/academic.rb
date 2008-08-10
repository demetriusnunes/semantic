require 'semantic'

module AcademicExample
  namespace "http://www.cs.rpi.edu/~puninj/XMLJ/course_schema.rdf"
  
  # rdfs:Class Person -> rdfs:subClassOf Resource
  class Person < Rdfs::Resource
    comment "Person Class"
  end

  class Student < Person
    comment "Student Class"
  end
  
  class Teacher < Person
    comment "Teacher Class"
  end

  class Course < Rdfs::Resource
    comment "Course Class"
    property :teacher, :range => Teacher # implicit domain
  end
  
  property :name do
    comment "Name of a Person or Course"
    domain [ Person, Course ]
    range Rdf::Literal    
  end
  
  property :students do
    comment "List of Students of a course in alphabetical order"
    domain Course
    range Rdf::Seq    
  end
end

include AcademicExample

$csci_2961 = Course.new("csci_2962") { |c|
  c.name = "Programming XML in Java"
  c.teacher = Teacher.new("jp") { |t| t.name = "John Punin" }
  c.students << Student.new("er") { |s| s.name = "Elizabeth Roberts" }
  c.students << Student.new("gl") { |s| s.name = "George Lucas" }
  c.students << Student.new("js") { |s| s.name = "John Smith" }
}
puts $csci_2961.to_xml
