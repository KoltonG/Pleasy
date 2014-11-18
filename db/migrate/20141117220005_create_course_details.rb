class CreateCourseDetails < ActiveRecord::Migration
  def change
    create_table :course_details do |t|
      t.string :dept
      t.string :number
      t.integer :year
      t.string :name
      t.integer :credits
      t.boolean :writing
      t.text :prereq
      t.text :coreq
      t.text :description

      t.timestamps
    end
  end
end
