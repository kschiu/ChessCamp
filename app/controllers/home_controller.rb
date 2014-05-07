class HomeController < ApplicationController
  def index
  	@upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(5)
    @past_camps = Camp.past.chronological.paginate(:page => params[:page]).per_page(5)
    @inactive_camps = Camp.inactive.alphabetical.to_a
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
