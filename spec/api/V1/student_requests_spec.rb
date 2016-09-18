require 'rails_helper'
describe "Student API" do
	describe "get /students" do
		it 'returns a JSON collection of all the students' do
			Student.create(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "F")
	    Student.create(first_name: "Jacob", last_name: "Dowd", age: 26, gender: "M")
	    get '/api/v1/students'
	    response_body = JSON.parse(response.body)
	    expect(response).to be_success
	    expect((response_body).length).to eq(2)
	    expect(response_body.first["teachers"]).to eq([])
		end
	end
  describe "get /students/1" do
		it 'returns a JSON collection of one student' do
			student_one = Student.create(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "F")
	    get '/api/v1/students/1'
	    response_body = JSON.parse(response.body)
	    expect(response).to be_success
	    expect(response_body["first_name"]).to eq(student_one.first_name)
		end
	end

  describe "post /students" do
		context "when valid" do
			it 'create a student' do
		    post '/api/v1/students', {student: {first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "F" }}
		    response_body = JSON.parse(response.body)
		    expect(response).to be_success
		    student_one = Student.first
		    expect(Student.count).to eq(1)
		    expect(student_one.first_name).to eq("Alice")
		    expect(student_one.last_name).to eq("Kallaugher")
		    expect(student_one.age).to eq(26)
		    expect(student_one.gender).to eq("F")
		    expect(response_body["first_name"]).to eq("Alice")
			end
		end
		context "when invalid" do
			it 'returns an error and message' do
		    post '/api/v1/students', {student: {last_name: "Kallaugher", age: 26, gender: "F" }}
		    response_body = JSON.parse(response.body)
		    expect(response.status).to eq(500) 
		    expect(response_body).to eq({"first_name" => ["can't be blank"]})
			end
		end
	end

  describe "patch /students/:id" do
		context "when valid" do
			it 'updates a student' do
				Student.create(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "F")
		    patch '/api/v1/students/1', {student: {age: 27}}
		    student_one = Student.first
		    expect(response).to be_success
		    expect(Student.count).to eq(1)
		    expect(student_one.first_name).to eq("Alice")
		    expect(student_one.last_name).to eq("Kallaugher")
		    expect(student_one.age).to eq(27)
		    expect(student_one.gender).to eq("F")
			end
		end
		context "when invalid" do
			it 'returns an error and message' do
				Student.create(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "F")
		    patch '/api/v1/students/1', {student: {first_name: ""}}
		    response_body = JSON.parse(response.body)
		    expect(response.status).to eq(500) 
		    expect(response_body).to eq({"first_name" => ["can't be blank"]})
			end
		end
	end

	describe "destroy /students/:id" do
		context "when valid" do
			it 'deletes a student' do
				Student.create(first_name: "Alice", last_name: "Kallaugher", age: 26, gender: "F")
		    delete '/api/v1/students/1'
		    expect(response).to be_success
		    expect(Student.count).to eq(0)
		 	end
		end
		context "does not exist" do
			it 'returns an error and message' do
		    delete '/api/v1/students/1'
		    expect(response.status).to eq(404) 
		    expect(JSON.parse(response.body)).to eq({"error" => "student with id of 1 not found"})
			end
		end
	end

end