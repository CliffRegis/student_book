require 'rails_helper'
describe 'Teacher API' do
  describe 'get /teachers' do
    it 'returns a JSON collection of all teachers' do
      Teacher.create(first_name: "Cliff", last_name: "Regis", age: 26, gender: "M")
	    Teacher.create(first_name: "Sophie", last_name: "DeBenedetto", age: 26, gender: "F")
      get '/api/v1/teachers'
      response_body = JSON.parse(response.body)
      expect(response).to be_success
      expect((response_body).length).to eq(2)
      expect(response_body.first["students"]).to eq([])
    end
  end
  describe 'get /teachers/1' do
    it 'returns a JSON collection of one teacher' do
      teacher = Teacher.create(first_name: "Cliff", last_name: "Regis", age: 26, gender: "M")
      get '/api/v1/teachers/1'
      response_body = JSON.parse(response.body)
      expect(response).to be_success
      expect(response_body["first_name"]).to eq(teacher.first_name)
    end
  end
  describe 'post /teachers' do
    context 'when valid' do
      it 'creates a new teacher' do
        post '/api/v1/teachers', {teacher: {first_name: "Cliff", last_name: "Regis", age: 26, gender: "M"}}
        response_body = JSON.parse(response.body)
        expect(response).to be_success
        teacher_one = Teacher.first
        expect(Teacher.count).to eq(1)
        expect(teacher_one.first_name).to eq("Cliff")
        expect(teacher_one.last_name).to eq("Regis")
        expect(teacher_one.age).to eq(26)
        expect(teacher_one.gender).to eq("M")
        expect(response_body["first_name"]).to eq("Cliff")
      end
    end
    context 'when invalid' do
      it 'returns an error and message' do
        post '/api/v1/teachers', {teacher: {last_name: "Regis", age: 26, gender: "M"}}
        response_body = JSON.parse(response.body)
        expect(response.status).to eq(500)
        expect(response_body).to eq({"first_name" => ["can't be blank"]})
      end
    end
  end
  describe 'patch /teachers/:id' do
    context 'when valid' do
      it 'updates a teacher' do
        Teacher.create(first_name: "Cliff", last_name: "Regis", age: 26, gender: "M")
        patch '/api/v1/teachers/1', {teacher: {first_name: "Cliff", last_name: "Regis", age: 27, gender: "M"}}
        expect(response).to be_success
        teacher_one = Teacher.first
        expect(Teacher.count).to eq(1)
        expect(teacher_one.first_name).to eq("Cliff")
        expect(teacher_one.last_name).to eq("Regis")
        expect(teacher_one.age).to eq(27)
        expect(teacher_one.gender).to eq("M")
      end
    end
    context 'when invalid' do
      it 'returns an error and message' do
        Teacher.create(first_name: "Cliff", last_name: "Regis", age: 26, gender: "M")
        patch '/api/v1/teachers/1', {teacher: {first_name: nil}}
        response_body = JSON.parse(response.body)
        expect(response.status).to eq(500)
        expect(response_body).to eq({"first_name" => ["can't be blank"]})
      end
    end
  end
  describe 'destroy /teachers/:id' do
    context 'when valid' do
      it 'deletes a teacher' do
        Teacher.create(first_name: "Cliff", last_name: "Regis", age: 26, gender: "M")
        delete '/api/v1/teachers/1'
        expect(response).to be_success
        expect(Teacher.count).to eq(0)
      end
    end
    context 'when invalid' do
      it 'returns an error and message' do
        delete '/api/v1/teachers/1'
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)).to eq({"error" => "teacher with id of 1 not found"})
      end
    end
  end

end
