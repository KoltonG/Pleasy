json.array!(@course_details) do |courses_user|
  json.extract! courses_user, :course_id, :user_id, :year, :term, :status
  json.url course_detail_url(courses_user, format: :json)
end
