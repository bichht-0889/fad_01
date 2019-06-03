class CategoriesController < ApplicationController
  before_action :check_loggin, :check_role_admin
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new category_params
    @category.status = 1
    if @category.save
      flash[:success] = t "categories.cate_created"
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to)
    else
      render :new
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit :name
  end
end
