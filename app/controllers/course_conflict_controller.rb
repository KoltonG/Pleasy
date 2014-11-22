class CourseConflictController < ActionController::Base

  #Code from stackoverflow
  # "So, I have an Event model that has a starts_at and a ends_at column and I want to find events that take place in a range of dates."
  #Solution:
  named_scope :in_range, lambda { |range|
    {:conditions => [
        '(time_start BETWEEN ? AND ? OR time_end BETWEEN ? AND ?) OR (time_start <= ? AND time_end >= ?)',
        range.first, range.last, range.first, range.last, range.first, range.last
    ]}
  }

end