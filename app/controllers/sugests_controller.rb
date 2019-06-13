class SugestsController < ApplicationController
  before_action :load_category, only: :create
  def index
    @categories = Category.order_categories
  end

  def create
    @sugest = current_user.sugests.build sugest_params
    @sugest.new_cate! if params[:sugest][:new_category].present?
    if @sugest.save
      flash[:success] = t "suggestions.create_success"
      redirect_to sugests_path
    else
      render :new
    end
  end

  private

  def sugest_params
    params.require(:sugest).permit :name, :description, :category_id, :new_category
  end

  def load_category
    @category = Category.find_by id: params[:sugest][:category_id]
    return if @category
    flash[:danger] = t "categories.category_not_found"
    redirect_to sugests_path
  end
end
