class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, except: %i(index create new)
  before_action :logged_in_user, except: %i(new show create)
  before_action :correct_user, only: %i(edit update)

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

  def edit; end

  def show; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controllers.user.update_success"
      return redirect_to admin_users_path if current_user.admin?
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :phone, :address, :picture
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controllers.user.id_not_found"
    redirect_to root_path
  end

  def logged_in_user
    return if signed_in?
    store_location
    flash[:danger] = t "controllers.user.not_login"
    redirect_to login_path
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end
end
