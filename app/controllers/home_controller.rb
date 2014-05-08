class HomeController < ApplicationController
  def index
  	@upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(5)
    @active_locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(5)
    @active_curriculums = Curriculum.active.alphabetical.paginate(:page => params[:page]).per_page(5)
    @student = Student.all
    if logged_in? && current_user.role =='instructor'
      @instructor_camps = Instructor.find(current_user.instructor_id).camps.upcoming.chronological.paginate(:page => params[:page]).per_page(5)
      @instructor_students = Instructor.find(current_user.instructor_id).camps.first.students.paginate(:page => params[:page]).per_page(5)
    end

  end

  def about
  end

  def contact
  end

  def privacy
  end

end
