class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(create)

  def create
    load_product
    @comment = current_user.comments.build(comment_params)
    @comment.product_id = params[:product_id]
    if @comment.save
      redirect_to product_path(@product)
    else
      flash[:danger] = t "products.err_cmt"
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.product_not_found"
    redirect_to root_path
  end
end
