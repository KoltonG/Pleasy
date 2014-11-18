class CreateProfs < ActiveRecord::Migration
  def change
    create_table :profs do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
