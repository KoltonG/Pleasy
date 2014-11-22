class AddCourseDetailsIdToPrerequisites < ActiveRecord::Migration
  def change
    add_column :prerequisites, :course_detail_id, :integer
  end
end
