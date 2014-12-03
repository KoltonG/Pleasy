class DashboardController < ApplicationController

  def BCS
    @core_courses = Course.joins('LEFT JOIN course_details ON courses.number = course_details.number AND courses.dept = course_details.dept ').
        select("courses.dept, courses.number, course_details.description, course_details.name").
        where("(courses.dept = 'CS' or courses.dept = 'INFO') and courses.city = 'Fredericton' and (courses.number ='1073' or courses.number = '1083' or courses.number = '1103' or courses.number = '1303'
              or courses.number = '2043' or courses.number = '2253' or courses.number = '2333'
              or courses.number = '2383' or courses.number = '3383' or courses.number = '3413'
              or courses.number = '3853' or courses.number = '3873' or courses.number = '3997')").
        uniq.order("dept, number")

    @tech_courses = Course.joins('LEFT JOIN course_details ON courses.number = course_details.number AND courses.dept = course_details.dept ').
        select("courses.dept, courses.number, course_details.description, course_details.name").
        where("(courses.dept = 'CS' or courses.dept = 'INFO' or courses.dept = 'SWE') and courses.city = 'Fredericton' and  (
        CONCAT ( courses.dept, courses.number ) not in ('CS1073','CS1083','CS1303','CS2043','CS2253','CS2333','CS2383','CS3383','CS3413','CS3853','CS3873','CS3997', 'INFO1103', 'CS5865', 'CS6605', 'CS6705', 'CS6735', 'CS6795', 'CS6895', 'CS6905', 'CS6991', 'CS6996', 'CS6997', 'CS6025', 'CS6035', 'CS6075', 'CS6355')
        ) and courses.credits >= 3").
        uniq.order("dept, number")

    @math_stat_courses = Course.joins('LEFT JOIN course_details ON courses.number = course_details.number AND courses.dept = course_details.dept ').
        select("courses.dept, courses.number, course_details.description, course_details.name").
        where("(courses.dept = 'MATH' or courses.dept = 'STAT') and courses.city = 'Fredericton' and (courses.number ='1003' or courses.number = '1013' or courses.number = '1503' or courses.number = '2213'
              or courses.number = '2593' or courses.number = '3083' or courses.number = '3033'
              or courses.number = '3063' or courses.number = '3093' or courses.number = '3213'
              or courses.number = '3333' or courses.number = '3343' or courses.number = '3353'
              or courses.number = '3363' or courses.number = '3373' or courses.number = '4063'
              or courses.number = '3093' or courses.number = '4333' or courses.number = '3113'
              or courses.number = '3413')").
        uniq.order("dept, number")

    @courses_taken  = []

    @course_enrolled = []

  end

  def taken
    if request.xhr?

      @courses = {
          'CS1073' => 'available',
          'CS1303' => 'available',
          'CS1003' => 'available',
          'CS1203' => 'available',
          'INFO1003' => 'available',
          'MATH1003' => 'available',
          'MATH1503' => 'available'
      }


      action = params[:act]
      selected_course = params[:dept] + params[:number]
      course_array = params[:taken]

      if course_array
        course_array.each do |taken|
          @courses[taken] = 'taken'
        end
      end


      selected_course_record = CourseDetail.where("course_details.year = '2014' AND CONCAT(dept, number) = '" + selected_course + "'").take!
      course_action_record = CoursesUser.new
      course_action_record.user_id = current_user.id
      course_action_record.year = 2014
      course_action_record.term = 'Winter'
      course_action_record.course_id = selected_course_record.id


      if action == 'taken'
        @courses[selected_course] = 'taken'
        course_action_record.status = 2
        course_action_record.save

      else
        @courses[selected_course] = 'enrolled'
        course_action_record.status = 1
        course_action_record.save
      end

      searchCourse!

      render :json => @courses
    end
  end

  def searchCourse!

    if @courses['CS1073'] == 'taken' || @courses['CS1073'] == 'enrolled' #CS1073
      @courses['CS1083'] = 'available' if !@courses['CS1083']
      @courses['INFO1103'] = 'available' if !@courses['INFO1103']
      @courses['CS3703'] = 'available'  if !@courses['CS3703']

      if @courses['CS1083'] == 'taken' || @courses['CS1083'] == 'enrolled' #CS1083
        @courses['CS2043'] = 'available' if !@courses['CS2403']
        @courses['CS2253'] = 'available' if !@courses['CS2253']

        if @courses['CS2043'] == 'taken' || @courses['CS2403'] == 'enrolled' #CS2043
          @courses['CS3025'] = 'available' if !@courses['CS3025']
          @courses['CS2053'] = 'available' if !@courses['CS2053']
          @courses['CS3043'] = 'available' if !@courses['CS3043']
        end

        if @courses['CS2253'] == 'taken' || @courses['CS2353'] == 'enrolled' #CS2253
          @courses['CS2053'] = 'available' if !@courses['CS2053']
          @courses['CS3413'] = 'available' if !@courses['CS3413']
          @courses['CS3853'] = 'available' if !@courses['CS3853']
          @courses['CS3873'] = 'available' if !@courses['CS3873']
          @courses['CS3997'] = 'available' if !@courses['CS3997']
        end

      end

      if @courses['INFO1103'] == 'taken' || @courses['INFO1103'] == 'enrolled' #INFO1103
        @courses['CS3503'] = 'available' if !@courses['CS3503']
      end

    end

    if @courses['CS1303'] == 'taken' || @courses['CS1303'] == 'enrolled'

      if (@courses['CS1073'] == 'taken' || @courses['CS1073'] == 'taken') || (@courses['CS1003'] == 'taken' || @courses['CS1003'] == 'taken')
        @courses['CS2333'] = 'available' if !@courses['CS2333']
      end

      if @courses['CS1083'] == 'taken' || @courses['CS1083'] == 'enrolled'
        @courses['CS2383'] = 'available' if !@courses['CS2383']
      end

      if ((@courses['CS2333'] == 'taken' || @courses['CS2333'] == 'enrolled') &&
          ((@courses['CS2333'] == 'taken' || @courses['CS2333'] == 'enrolled') || (@courses['CS3323'] == 'taken' || @courses['CS3323'] == 'enrolled')) &&
          ((@courses['STAT2593'] == 'taken' || @courses['STAT2593'] == 'enrolled') || (@courses['STAT3083'] == 'taken' || @courses['STAT3083'] == 'enrolled')))

        @courses['CS3383'] = 'available' if !@courses['CS3383']
      end

    end

  end

end
