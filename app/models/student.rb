class Student < ApplicationRecord
  has_many :courses
  has_many :teachers, through: :courses

  validates_inclusion_of :gender, :in => %w( m f M F)

end
