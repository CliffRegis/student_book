module Api
	module V1
		class StudentsController < ApplicationController
			
			def index
				render json: Student.all
			end
			
			def new
			end
			
			def create
        student = Student.new(student_params)
        if student.save
        	render json: student
        else
        	render json: student.errors, status: 500
        end
			end

			def show
        render json: Student.find(params[:id])
			end

			def edit

			end

			def update
				student = Student.find(params[:id])
        if student.update(student_params)
        	render json: student

        else
        	render json: student.errors, status: 500
        end
			end

			def destroy
				student = Student.find_by(id: params[:id])
        if student
        	student.destroy
        	head :ok 

        else
        	render json: {"error" => "student with id of #{params[:id]} not found"}, status: 404
        end

			end

			private

			def student_params
					params.require(:student).permit(:first_name, :last_name, :age, :gender)
			end

		end
	end
end