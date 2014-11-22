class CoursesUser < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  #The course the user is trying to sign up for has a start and end time.
    #If this course takes place on monday then (if: :daymon?),
      #Then, look at the rest of the courses that the user has enrolled in that has the same start and end time, AND is in whichever term is selected, AND is in whichever year is selected. If one exists, return a record overlapping error.
    #Else validation passes and the record is created, provided that the rest of the validations below (one for each day of the week) passes

  validates "courses.time_start", "courses.time_end",
            :overlap => {
                :query_options => {:includes => :course},
                :scope => { "courses_users.user_id" => proc{|courses_user| courses_user.user_id}, "courses.day_mon" => true, "courses.term" => proc{|course| course.term}, "courses.year" => proc{|course| course.year}}
            }, if: :daymon?

  validates "courses.time_start", "courses.time_end",
            :overlap => {
                :query_options => {:includes => :course},
                :scope => { "courses_users.user_id" => proc{|courses_user| courses_user.user_id}, "courses.day_tue" => true, "courses.term" => proc{|course| course.term}, "courses.year" => proc{|course| course.year} }   #proc{|course| course.year}
            }, if: :daytue?

  validates "courses.time_start", "courses.time_end",
            :overlap => {
                :query_options => {:includes => :course},
                :scope => { "courses_users.user_id" => proc{|courses_user| courses_user.user_id}, "courses.day_wed" => true, "courses.term" => proc{|course| course.term}, "courses.year" => proc{|course| course.year} }
            }, if: :daywed?

  validates "courses.time_start", "courses.time_end",
            :overlap => {
                :query_options => {:includes => :course},
                :scope => { "courses_users.user_id" => proc{|courses_user| courses_user.user_id}, "courses.day_thu" => true, "courses.term" => proc{|course| course.term}, "courses.year" => proc{|course| course.year} }
            }, if: :daythu?

  validates "courses.time_start", "courses.time_end",
            :overlap => {
                :query_options => {:includes => :course},
                :scope => { "courses_users.user_id" => proc{|courses_user| courses_user.user_id}, "courses.day_fri" => true, "courses.term" => proc{|course| course.term}, "courses.year" => proc{|course| course.year} }
            }, if: :dayfri?

  validates "courses.time_start", "courses.time_end",
            :overlap => {
                :query_options => {:includes => :course},
                :scope => { "courses_users.user_id" => proc{|courses_user| courses_user.user_id}, "courses.day_sat" => true, "courses.term" => proc{|course| course.term}, "courses.year" => proc{|course| course.year} }
            }, if: :daysat?

  validates "courses.time_start", "courses.time_end",
            :overlap => {
                :query_options => {:includes => :course},
                :scope => { "courses_users.user_id" => proc{|courses_user| courses_user.user_id}, "courses.day_sun" => true, "courses.term" => proc{|course| course.term}, "courses.year" => proc{|course| course.year} }
            }, if: :daysun?

  #If the course the user is trying to sign up for is on monday (courses.day_mon == true), then return true!
  def daymon?
    self.course.day_mon?
  end
  def daytue?
    self.course.day_tue?
  end
  def daywed?
    self.course.day_wed?
  end
  def daythu?
    self.course.day_thu?
  end
  def dayfri?
    self.course.day_fri?
  end
  def daysat?
    self.course.day_sat?
  end
  def daysun?
    self.course.day_sun?
  end
end

#def daytest? (var1)
#  if var1 == "mon"
#    self.course.day_mon?
#    elseif var1 == "tue"
#    self.course.day_tue?
#  end
#end

#class ActiveMeeting < ActiveRecord::Base
#  validates :starts_at, :ends_at, :overlap => {:query_options => {:active => nil}}
#  scope :active, where(:is_active => true)
#end

#  validates_presence_of :time_start, :time_end

# Check if a given interval overlaps this interval
#  def overlaps?(other)
#    (time_start - other.time_end) * (other.time_start - time_end) >= 0
#  end

# Return a scope for all interval overlapping the given interval, including the given interval itself
#  named_scope :overlapping, lambda { |interval| {
#      :conditions => ["id <> ? AND (TIMEDIFF(time_start, ?) * TIMEDIFF(?, time_end)) >= 0", interval.id, interval.time_end, interval.time_start]
#  }}




#
# named_scope :in_range, lambda { |range|
#  {:conditions => [
#      '(starts_at BETWEEN ? AND ? OR ends_at BETWEEN ? AND ?) OR (starts_at <= ? AND ends_at >= ?)',
#      range.first, range.last, range.first, range.last, range.first, range.last
#  ]}
#  }
