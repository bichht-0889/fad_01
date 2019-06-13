class CategoriesController < ApplicationController
  before_action :check_loggin, :check_role_admin
  before_action :load_category, only: %i(edit update destroy)

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all.paginate(page:
    params[:page], per_page: Settings.pages.per_page)
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

  def destroy
    @category.close!
    flash[:success] = t "categories.notice_del"
    redirect_to categories_path
  rescue
    flash[:danger] = t "categories.notice_del_fail"
    redirect_to categories_path
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:info] = t "categories.category_not_found"
    redirect_to categories_path
  end
end
