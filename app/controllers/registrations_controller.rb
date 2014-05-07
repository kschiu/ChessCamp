class RegistrationsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
  end

  def show
  end

  def new
    @registration = Registration.new
    @camps = camp_array
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to @registration, notice: "Registration was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to @registration, notice: "Registration was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @registration.destroy
    redirect_to registrations_url, notice: "Registration was removed from the system."
  end

  private

  	def camp_array
  		camps = []
  		Camp.upcoming.active.alphabetical.each do |c|
  			camps << [c.curriculum.name + " taught at " + c.location.name + " on "+ c.start_date.strftime("%b %d, %Y") , c.id]
  		end	
  		return camps
  	end

    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
    end
end


