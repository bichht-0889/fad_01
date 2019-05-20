class CategoriesController < ApplicationController
  authorize_resource

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

  private

  def category_params
    params.require(:category).permit :name
  end
end
