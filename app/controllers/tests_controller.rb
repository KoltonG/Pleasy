class TestsController < ApplicationController
  respond_to :html

  def index
    restricted_where= 'prerequisites.id IS NOT NULL and (courses_users.user_id <> '.concat( current_user.id.to_s ).concat(' or courses_users.user_id is null)')
    available_where= 'prerequisites.id IS NULL or (courses_users.user_id = '.concat( current_user.id.to_s ).concat(' )')
    @restricted_courses =
        CourseDetail.joins('LEFT JOIN prerequisites ON prerequisites.course_detail_id = course_details.id').joins('LEFT JOIN courses_users on prerequisites.prereq_id = courses_users.course_id').where(restricted_where)
    @available_courses =
        CourseDetail.joins('LEFT JOIN prerequisites ON prerequisites.course_detail_id = course_details.id').joins('LEFT JOIN courses_users on prerequisites.prereq_id = courses_users.course_id').where(available_where)

    #@test = @available_courses.joi
    #???#respond_with(@prerequisites)
  end

  def index2
    @courses = Course.select("dept, number, name")
    respond_with(@courses)
  end

end