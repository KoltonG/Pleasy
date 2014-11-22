class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :term
      t.integer :year
      t.string :dept
      t.string :number
      t.string :section
      t.integer :section_number
      t.string :name
      t.string :city
      t.string :style
      t.boolean :day_sun
      t.boolean :day_mon
      t.boolean :day_tue
      t.boolean :day_wed
      t.boolean :day_thu
      t.boolean :day_fri
      t.boolean :day_sat
      t.boolean :day_sun
      t.time :time_start
      t.time :time_end
      t.string :room
      t.string :location
      t.boolean :lab
      t.string :lab_style
      t.string :lab_location
      t.boolean :lab_day_sun
      t.boolean :lab_day_mon
      t.boolean :lab_day_tue
      t.boolean :lab_day_wed
      t.boolean :lab_day_thu
      t.boolean :lab_day_fri
      t.boolean :lab_day_sat
      t.boolean :lab_day_sun
      t.time :lab_time_start
      t.time :lab_time_end
      t.string :prof_name
      t.integer :credits

      t.timestamps
    end
  end
end
