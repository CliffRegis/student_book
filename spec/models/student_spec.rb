require 'rails_helper'

RSpec.describe Student, type: :model do
	let(:female_student) {student = Student.new(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "F")}
	let(:male_student) {student = Student.new(first_name: "Jacob", last_name: "Dowd", age: 26, gender: "M")}
     it "should be valid with first name, last name and age" do
	 	expect(male_student).to be_valid
	 end

    it "should be not valid without first name, last name and age" do
    	bad_student = Student.new(gender: "M")
    	expect(bad_student).to_not be_valid
    end


    it "should be valid with gender as 'm', 'M', 'F' or 'f' " do
        expect(female_student).to be_valid
        expect(male_student).to be_valid
    end
    
    it "should be not valid with gender that is not 'm' or 'f' " do
        bad_female_student = Student.new(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "female")
        bad_male_student = Student.new(first_name: "Jacob", last_name: "Dowd", age: 26, gender: "Male")
        expect(bad_female_student).to_not be_valid
        expect(bad_male_student).to_not be_valid
    end
end
