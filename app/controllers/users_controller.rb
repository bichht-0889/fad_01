class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "controllers.user.sign_up_success", name: @user.name,
                        date: @user.created_at
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :phone, :address, :picture
  end
end
