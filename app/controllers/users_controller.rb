class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update]
authorize_resource

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(home_path, :notice => 'User was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated User"
      redirect_to @user
    else
      render action: 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :instructor_id, :role, :password, :password_confirmation, :active)
  end

end