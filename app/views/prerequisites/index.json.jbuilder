json.array!(@prerequisites) do |prerequisite|
  json.extract! prerequisite, :id, :course_detail_id, :prereq_id
  json.url prerequisite_url(prerequisite, format: :json)
end
