class SugestsController < ApplicationController
  def index
    @categories = Category.all
  end
  
  def create
    @sugest = current_user.sugests.build sugest_params
    if @sugest.save
      flash[:success] = t "suggestions.create_success"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def sugest_params
    params.require(:sugest).permit :name, :description, :category_id
  end
end