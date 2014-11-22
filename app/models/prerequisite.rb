class Prerequisite < ActiveRecord::Base
  belongs_to :course_detail
  belongs_to :prereq, :class_name => "Course"
end
