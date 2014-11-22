class Tests2Controller < ApplicationController
  respond_to :html


  def index
    selectedterm = "Winter"
    @courses = Course.joins('LEFT JOIN course_details ON courses.number = course_details.number AND courses.dept = course_details.dept ').select("courses.dept, courses.number, courses.name, course_details.description").where("courses.term = ?  ", selectedterm).uniq.order("dept, number")

    respond_with(@courses)
  end

end