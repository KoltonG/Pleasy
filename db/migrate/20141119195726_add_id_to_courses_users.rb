class AddIdToCoursesUsers < ActiveRecord::Migration
  def change
    add_column :courses_users, :id, :primary_key
  end
end
