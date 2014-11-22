class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :courses, :users do |t|  #
      t.belongs_to :course #has-many :through association
      t.belongs_to :user #has-many :through association
      t.integer :year #To define when a user took a course
      t.string :term #To define when a user took a course
      t.integer :status #Status of the course a user took

      t.timestamps
    end
  end
end