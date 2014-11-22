class CourseDetail < ActiveRecord::Base
  has_many :prerequisites
  has_many :prereqs, :through => :prerequisites

  has_many :inverse_prerequisites, :class_name => "Prerequisite", :foreign_key => "prereq_id"
  has_many :inverse_prereqs, :through => :inverse_prerequisites, :source => :course_detail

end
