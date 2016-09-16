class Student < ApplicationRecord
  has_many :courses
  has_many :teachers, through: :courses
  validates_inclusion_of :gender, :in => %w( m f M F)
  validates :first_name, :last_name, :age, presence: true
end
