class Teacher < ApplicationRecord
  has_many :courses
  has_many :students, through: :courses

  validates_inclusion_of :gender, :in => %w( m f M F)

end
