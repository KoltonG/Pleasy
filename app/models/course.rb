class Course < ActiveRecord::Base
  has_many :users_courses
  has_many :users, through: :users_courses

  has_many :prerequisites
  has_many :prereqs, :through => :prerequisites

  has_many :inverse_prerequisites, :class_name => "Prerequisite", :foreign_key => "prereq_id"
  has_many :inverse_prereqs, :through => :inverse_prerequisites, :source => :course

  #has_many :sections, class_name: "Course", foreign_key: "id"
  #has_many :sections, class_name: "course," :finder_sql => 'SELECT * FROM items WHERE (items.user_id = #{id} or items.renter_id = #{id})'
  #has_many :sections, class_name: "Course", : :finder_sql =>  'SELECT * FROM courses WHERE (courses.dept = #{dept} and courses.number = #{number})'

  #def sections
  #  Course.with_section(id)
  #end

  #scope :with_section, lambda{ |number, dept| { :conditions=>["number = ? or dept = ?", number, dept]}}
  def sections
    Course.with_section(number, dept)
  end
  scope :with_section, lambda {|number, dept| where('number = ? AND dept = ? ', number, dept) }
end

