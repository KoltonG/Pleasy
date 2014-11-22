json.array!(@course_details) do |course_detail|
  json.extract! course_detail, :id, :dept, :number, :year, :name, :credits, :writing, :prereq, :coreq, :description
  json.url course_detail_url(course_detail, format: :json)
end
