class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.belongs_to :student, foreign_key: true
      t.belongs_to :teacher, foreign_key: true

      t.timestamps
    end
  end
end
