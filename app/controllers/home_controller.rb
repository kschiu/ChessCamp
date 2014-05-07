class HomeController < ApplicationController
  def index
  	@upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(5)
    @active_locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(5)
    @active_curriculums = Curriculum.active.alphabetical.paginate(:page => params[:page]).per_page(5)
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
