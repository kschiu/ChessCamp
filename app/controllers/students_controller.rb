class StudentsController < ApplicationController
include ActionView::Helpers::NumberHelper
before_action :set_student, only: [:show, :edit, :update, :destroy]

	def family_array
		result = []
		Family.active.alphabetical.each do |f|
			b = []
			b << f.family_name
			b << f.id
			result << b
		end
		return result
	end

	def create
		@student = Student.new(student_params)
		@families = family_array
		if @student.save
			redirect_to @student, notice: "#{@student.proper_name} was added to the system."
		else
			render action: 'new'
		end
	end

	def new
		@student = Student.new
		@families = family_array
	end

	def update
		@families = family_array
		if @student.update(student_params)
			redirect_to @student, notice: "#{@student.proper_name} was revised in the system."
		else
			render action: 'edit'
		end
	end

	def destroy
		@student.destroy
		redirect_to students_url, notice: "#{@student.proper_name} was removed from the system."
	end

	def index
		@active_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
		@inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def edit
	end

	def show
		@camps = @student.camps.to_a
	end

  	private
    def set_student
    	@student = Student.find(params[:id])
    end

    def student_params
    	params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active, :camp_ids => [])
    end


end