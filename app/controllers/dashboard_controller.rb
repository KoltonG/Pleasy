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
  end

end
