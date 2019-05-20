class Admin::UsersController < ApplicationController
  before_action :check_loggin, :check_role_admin
  before_action :load_user, except: %i(index create new)

  def index
    @user = User.paginate(page: params[:page],
      per_page: Settings.app.admin.users.per_page).asc_name
  end

  def destroy
    ActiveRecord::Base.transaction do
      if params[:role] == Settings.app.admin.users.block
        delete_block @user
      elsif params[:role] == Settings.app.admin.users.member
        delete_member @user
      elsif params[:role] == Settings.app.admin.users.unblock
        delete_unblock @user
      end
      redirect_to admin_users_path
    end
  rescue NoMethodError
    flash[:danger] = t "controllers.admin.user.danger"
    redirect_to admin_users_path
  end

  def edit; end

  def show; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controllers.admin.user.success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:info] = t "controllers.admin.user.not_found"
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :phone, :address, :picture
  end

  def delete_user_exists_cancel orders
    orders.map(&:cancel_quatity_product)
  end

  def delete_member user
    @order_confirm = user.orders.confirm
    @order_accept = user.orders.accept
    if @order_accept.present?
      flash[:info] = t "controllers.admin.user.accept",
        count: @order_accept.count
    else
      delete_user_exists_cancel @order_confirm if @order_confirm.present?
      user.destroy
      flash[:info] = t "controllers.admin.user.success",
        count: @order_confirm.size
    end
  end

  def delete_block user
    user.block!
    flash[:info] = t "controllers.admin.user.block", name: user.name
  end

  def delete_unblock user
    user.member!
    flash[:info] = t "controllers.admin.user.unblock", name: user.name
  end
end
