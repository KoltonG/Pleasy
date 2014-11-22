json.array!(@course_details) do |course_detail|
  json.extract! course_detail, :id, :course_detail_id, :prereq_id
  json.url prerequisite_url(prerequisite, format: :json)
end
