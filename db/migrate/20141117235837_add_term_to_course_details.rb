class AddTermToCourseDetails < ActiveRecord::Migration
  def change
    add_column :course_details, :term, :string
  end
end
