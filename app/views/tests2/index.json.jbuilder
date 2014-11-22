json.array!(@course_details) do |course_detail|
  json.extract! course, :dept, :number, :name, :section
  json.url prerequisite_url(prerequisite, format: :json)
end
