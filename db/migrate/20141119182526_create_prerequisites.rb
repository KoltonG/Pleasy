class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites do |t|
      t.integer :course_id
      t.integer :prereq_id

      t.timestamps
    end
  end
end
