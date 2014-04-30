class UsersController < ApplicationController
before_action :check_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = @current_user
  end

  def create
    if @user.save
      session[:user_id] = @user.id
      redirect_to(home_path, :notice => 'User was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @user = @current_user

    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated User"
      redirect_to @user
    else
      render action: 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :instructor_id, :role, :password, :password_confirmation, :active)
  end

end