json.array!(@courses) do |course|
  json.extract! course, :id, :term, :year, :dept, :number, :section, :section_number, :name, :city, :style, :day_sun, :day_mon, :day_tue, :day_wed, :day_thu, :day_fri, :day_sat, :day_sun, :time_start, :time_end, :room, :location, :lab, :lab_style, :lab_location, :lab_day_sun, :lab_day_mon, :lab_day_tue, :lab_day_wed, :lab_day_thu, :lab_day_fri, :lab_day_sat, :lab_day_sun, :lab_time_start, :lab_time_end, :prof_name, :credits
  json.url course_url(course, format: :json)
end
