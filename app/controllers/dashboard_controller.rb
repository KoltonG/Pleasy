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


    #Courses you can't take based on prereqs table
    restricted_where= 'prerequisites.id IS NOT NULL and (courses_users.user_id <> '.concat( current_user.id.to_s ).concat(' or courses_users.user_id is null)')
    @restricted_courses =
        CourseDetail.joins('LEFT JOIN prerequisites ON prerequisites.course_detail_id = course_details.id').joins('LEFT JOIN courses_users on prerequisites.prereq_id = courses_users.course_id').joins('LEFT JOIN courses ON courses.number = course_details.number AND courses.dept = course_details.dept ').where(restricted_where)

    #Courses you can take based on prereqs table
    available_where= 'prerequisites.id IS NULL or (courses_users.user_id = '.concat( current_user.id.to_s ).concat(' )')
    @available_courses =
        CourseDetail.joins('LEFT JOIN prerequisites ON prerequisites.course_detail_id = course_details.id').joins('LEFT JOIN courses_users on prerequisites.prereq_id = courses_users.course_id').joins('LEFT JOIN courses ON courses.number = course_details.number AND courses.dept = course_details.dept ').where(available_where)

    #Courses that user has enrolled in
    @courses_enrolled_record = CoursesUser.joins("INNER JOIN course_details on course_details.id = courses_users.course_id").where("courses_users.status = 1 AND courses_users.user_id = '" + current_user.id.to_s + "'")

    #Courses that user has taken
    @courses_taken_record = CoursesUser.joins("INNER JOIN course_details on course_details.id = courses_users.course_id").where("courses_users.status = 2 AND courses_users.user_id = '" + current_user.id.to_s + "'")

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


      if @courses_taken_record
        @courses_taken_record.each do |taken_course|
          @courses[taken_course.dept + taken_course.name] = 'taken'
        end
      end

      if @courses_enrolled_record
        @courses_enrolled_record.each do |taken_course|
          @courses[taken_course.dept + taken_course.name] = 'enrolled'
        end
      end



      action = params[:act]
      selected_course = params[:course]
      taken_array = params[:taken]
      enrolled_array = params[:enrolled]

      if taken_array
        taken_array.each do |taken|
          @courses[taken] = 'taken'
        end
      end

      if enrolled_array
        enrolled_array.each do |enrolled|
          @courses[enrolled] = 'enrolled'
        end
      end


      # Get all course_details IDs that current_user has taken


      #taken_courses_record.each do |taken_course|
      #  taken_course.course_id
      #end

      # Get the course record the user clicked on
      selected_course_record = CourseDetail.where("course_details.year = '2014' AND CONCAT(dept, number) = '" + selected_course + "'").take!
      # Create a new user_courses transaction
      course_action_record = CoursesUser.new
      course_action_record.user_id = current_user.id
      course_action_record.year = 2014
      course_action_record.term = 'Winter'
      course_action_record.course_id = selected_course_record.id

      if action == 'taken'
        #Set to taken, save transaction status = 2
        @courses[selected_course] = 'taken'
        course_action_record.status = 2
        course_action_record.save
      else
        #Set to taken, save transaction status = 1
        @courses[selected_course] = 'enrolled'
        course_action_record.status = 1
        course_action_record.save
      end

      searchCourse!

      render :json => @courses
    end
  end

  def searchCourse!

    # BASE - CS 1073
    if @courses['CS1073'] == 'taken' || @courses['CS1073'] == 'enrolled' #CS1073
      @courses['CS1083'] = 'available' if !@courses['CS1083']
      @courses['INFO1103'] = 'available' if !@courses['INFO1103']
      @courses['CS3703'] = 'available'  if !@courses['CS3703']

      if @courses['CS1083'] == 'taken' || @courses['CS1083'] == 'enrolled' #CS1083
        @courses['CS2043'] = 'available' if !@courses['CS2043']
        @courses['CS2253'] = 'available' if !@courses['CS2253']

        if @courses['CS2043'] == 'taken' || @courses['CS2043'] == 'enrolled' #CS2043
          @courses['CS3025'] = 'available' if !@courses['CS3025']
          @courses['CS2053'] = 'available' if !@courses['CS2053']
          @courses['CS3043'] = 'available' if !@courses['CS3043']
          @courses['CS4015'] = 'available' if !@courses['CS4015']
          @courses['SWE4203'] = 'available' if !@courses['SWE4203']
          @courses['SWE4403'] = 'available' if !@courses['SWE4403']

        end

        if @courses['CS2253'] == 'taken' || @courses['CS2253'] == 'enrolled' #CS2253
          @courses['CS2053'] = 'available' if !@courses['CS2053']
          @courses['CS3413'] = 'available' if !@courses['CS3413']
          @courses['CS3853'] = 'available' if !@courses['CS3853']
          @courses['CS3873'] = 'available' if !@courses['CS3873']
          @courses['CS3997'] = 'available' if !@courses['CS3997']

          if @courses['CS2333'] == 'taken' || @courses['CS2333'] == 'enrolled'
            @courses['CS3613'] = 'available' if !@courses['CS3613']

            if @courses['CS2383'] == 'taken' || @courses['CS2383'] == 'enrolled'
              @courses['CS4725'] = 'available' if !@courses['CS4725']
            end

          end

          if (@courses['CS3413'] == 'taken' || @courses['CS3413'] == 'enrolled') && (@courses['CS3853'] == 'taken' || @courses['CS3853'] == 'enrolled')
            @courses['CS4405'] = 'available' if !@courses['CS4405']
          end

          if @courses['CS3853'] == 'taken' || @courses['CS3853'] == 'enrolled'
            @courses['CS4745'] = 'available' if !@courses['CS4745']
          end

        end

      end

      if @courses['INFO1103'] == 'taken' || @courses['INFO1103'] == 'enrolled' #INFO1103
        @courses['CS3503'] = 'available' if !@courses['CS3503']
        @courses['INFO3303'] = 'available' if !@courses['INFO3303']
        @courses['INFO3403'] = 'available' if !@courses['INFO3403']

        if @courses['CS1303'] == 'taken' || @courses['CS1303'] == 'enrolled'
          @courses['INFO2403'] = 'available' if !@courses['INFO2403']

          if @courses['INFO2403'] == 'taken' || @courses['INFO2403'] == 'enrolled'
            @courses['INFO3103'] = 'available' if !@courses['INFO3103']
          end
        end
      end

      if (@courses['MATH2213'] == 'taken' || @courses['MATH2213'] == 'enrolled') || (@courses['MATH1503'] == 'taken' || @courses['MATH1503'] == 'enrolled')
        @courses['CS3113'] = 'available' if !@courses['CS3113']
      end

    end

    # BASE - CS 1303
    if @courses['CS1303'] == 'taken' || @courses['CS1303'] == 'enrolled'

      if (@courses['CS1073'] == 'taken' || @courses['CS1073'] == 'enrolled') || (@courses['CS1003'] == 'taken' || @courses['CS1003'] == 'enrolled')
        @courses['CS2333'] = 'available' if !@courses['CS2333']
      end

      if @courses['CS1083'] == 'taken' || @courses['CS1083'] == 'enrolled'
        @courses['CS2383'] = 'available' if !@courses['CS2383']
      end

      if ((@courses['CS2333'] == 'taken' || @courses['CS2333'] == 'enrolled') &&
          ((@courses['CS2383'] == 'taken' || @courses['CS2383'] == 'enrolled') || (@courses['CS3323'] == 'taken' || @courses['CS3323'] == 'enrolled')) &&
          ((@courses['STAT2593'] == 'taken' || @courses['STAT2593'] == 'enrolled') || (@courses['STAT3083'] == 'taken' || @courses['STAT3083'] == 'enrolled')))

        @courses['CS3383'] = 'available' if !@courses['CS3383']

        if @courses['CS3383'] == 'taken' || @courses['CS3383'] == 'enrolled'
          @courses['CS4935'] = 'available' if !@courses['CS4935']
        end

      end

      if (@courses['MATH2213'] == 'taken' || @courses['MATH2213'] == 'enrolled') || (@courses['MATH1503'] == 'taken' || @courses['MATH1503'] == 'enrolled')
        @courses['MATH3033'] = 'available' if !@courses['MATH3033']
      end


    end

    # BASE - CS 1003
    if @courses['CS1003'] == 'taken' || @courses['CS1003'] == 'enrolled'
      @courses['CS1023'] = 'available' if !@courses['CS1023']

      if @courses['CS1023'] == 'taken' || @courses['CS1023'] == 'enrolled'
        @courses['CS2033'] = 'available' if !@courses['CS2033']
      end

      if (@courses['MATH2213'] == 'taken' || @courses['MATH2213'] == 'enrolled') || (@courses['MATH1503'] == 'taken' || @courses['MATH1503'] == 'enrolled')
        @courses['CS3113'] = 'available' if !@courses['CS3113']
      end

    end

    # BASE - CS 1203
    if @courses['CS1203'] == 'taken' || @courses['CS1203'] == 'enrolled'
      @courses['CS1023'] = 'available' if !@courses['CS1023']
    end

    # BASE - MATH 1003
    if @courses['MATH1003'] == 'taken' || @courses['MATH1003'] == 'enrolled'
      @courses['MATH1013'] = 'available' if !@courses['MATH1013']

      if @courses['MATH1013'] == 'taken' || @courses['MATH1013'] == 'enrolled'
        @courses['MATH2213'] = 'available' if !@courses['MATH2213']
        @courses['MATH3093'] = 'available' if !@courses['MATH3093']
        @courses['MATH3373'] = 'available' if !@courses['MATH3373']
        @courses['STAT2593'] = 'available' if !@courses['STAT2593']
        @courses['STAT3083'] = 'available' if !@courses['STAT3083']

        if @courses['STAT3083'] == 'taken' || @courses['STAT3083'] == 'enrolled'
          @courses['STAT3093'] = 'available' if !@courses['STAT3093']

          if @courses['STAT3093'] == 'taken' || @courses['STAT3093'] == 'enrolled'
            if (@courses['MATH1503'] == 'taken' || @courses['MATH1503'] == 'enrolled') || (@courses['MATH2213'] == 'taken' || @courses['MATH2213'] == 'enrolled')
              @courses['STAT3373'] = 'available' if !@courses['STAT3373']
            end
          end

        end

        if (@courses['MATH1503'] == 'taken' || @courses['MATH1503'] == 'enrolled') || (@courses['MATH2213'] == 'taken' || @courses['MATH2213'] == 'enrolled')
          @courses['MATH3063'] = 'available' if !@courses['MATH3063']
        end

        if @courses['MATH2213'] == 'taken' || @courses['MATH2213'] == 'enrolled'
          @courses['MATH3213'] = 'available' if !@courses['MATH3213']
          @courses['MATH3343'] = 'available' if !@courses['MATH3343']
        end

      end

    end

    # BASE - MATH 1503
    if @courses['MATH1503'] == 'taken' || @courses['MATH1503'] == 'enrolled'
      @courses['MATH3343'] = 'available' if !@courses['MATH3343']

      if @courses['CS2253'] == 'taken' || @courses['CS2253'] == 'enrolled'
        @courses['CS4735'] = 'available' if !@courses['CS4735']
      end

      if @courses['MATH1013'] == 'taken' || @courses['MATH1013'] == 'enrolled'
        @courses['MATH3213'] = 'available' if !@courses['MATH3213']
      end

    end

  end

end
