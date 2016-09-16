require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:female_teacher) {teacher = Teacher.new(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "F")}
	let(:male_teacher) {teacher = Teacher.new(first_name: "Jacob", last_name: "Dowd", age: 26, gender: "M")}
  it 'teacher is valid with first name, last name, and age' do
    expect(female_teacher).to be_valid
  end
  it 'teacher is invalid without first name, last name, and/or age' do
    bad_teacher = Teacher.new(gender: "M")
    expect(bad_teacher).to_not be_valid
  end
  it 'teacher is valid with gender (in proper format)' do
    expect(female_teacher).to be_valid
    expect(male_teacher).to be_valid
  end
  it 'teacher is invalid without gender' do
    bad_male_teacher = Teacher.new(first_name: "Jacob", last_name: "Dowd", age: 26)
    expect(bad_male_teacher).to_not be_valid
  end
  it 'teacher is invalid without gender in proper format' do
    bad_female_teacher = Teacher.new(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "female")
    bad_male_teacher = Teacher.new(first_name: "Jacob", last_name: "Dowd", age: 26, gender: "Male")
    expect(bad_female_teacher).to_not be_valid
    expect(bad_male_teacher).to_not be_valid
  end

  # it 'teacher can have many courses' #do
  #   # Teacher.reflect_on_association(:courses).macro.should eq(:has_many)
  # # end
  # it 'teacher can have many students' #do
  #   # Teacher.reflect_on_association(:students).macro.should eq(:has_many)
  # # end

  # relationship example:
  # it { Idea.reflect_on_association(:person).macro.should  eq(:belongs_to) }
  # it { Idea.reflect_on_association(:company).macro.should eq(:belongs_to) }
  # it { Idea.reflect_on_association(:votes).macro.should   eq(:has_many) }
end
