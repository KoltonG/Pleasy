class TestsController < ApplicationController
  respond_to :html

  def index
    restricted_where= 'prerequisites.id IS NOT NULL and (courses_users.user_id <> '.concat( current_user.id.to_s ).concat(' or courses_users.user_id is null)')
    available_where= 'prerequisites.id IS NULL or (courses_users.user_id = '.concat( current_user.id.to_s ).concat(' )')
    @restricted_courses =
        CourseDetail.joins('LEFT JOIN prerequisites ON prerequisites.course_detail_id = course_details.id').joins('LEFT JOIN courses_users on prerequisites.prereq_id = courses_users.course_id').joins('LEFT JOIN courses ON courses.number = course_details.number AND courses.dept = course_details.dept ').where(restricted_where)
    @available_courses =
        CourseDetail.joins('LEFT JOIN prerequisites ON prerequisites.course_detail_id = course_details.id').joins('LEFT JOIN courses_users on prerequisites.prereq_id = courses_users.course_id').joins('LEFT JOIN courses ON courses.number = course_details.number AND courses.dept = course_details.dept ').where(available_where)

    #These are all the courses the user current_user has taken, as we use an INNER JOIN instead of a left join, indicating that BOTH tables must have the ID on either side.
    #We can use the status column however we want to determine if it's an enrolled course or taken course (see the where statement).
    # Also, you will get duplicates, so use a ".select" statement to select only what you need, then they should go away
    @courses_enrolled =
        CourseDetail.joins('INNER JOIN courses_users on course_details.id = courses_users.course_id').joins('LEFT JOIN courses ON courses.number = course_details.number AND courses.dept = course_details.dept ').where('courses_users.status = 1 AND courses_users.user_id = ' + current_user.id.to_s ).uniq
    @courses_taken =
        CourseDetail.joins('INNER JOIN courses_users on course_details.id = courses_users.course_id').joins('LEFT JOIN courses ON courses.number = course_details.number AND courses.dept = course_details.dept ').where('courses_users.status = 1 AND courses_users.user_id = ' + current_user.id.to_s ).uniq


    #@test = @available_courses.joi
    #???#respond_with(@prerequisites)
  end

  def index2
    @courses = Course.select("dept, number, name")
    respond_with(@courses)
  end

end