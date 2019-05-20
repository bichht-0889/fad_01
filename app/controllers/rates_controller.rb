class RatesController < ApplicationController
  before_action :logged_in_user, :load_product, only: %i(create update)
  before_action :load_rate, only: :update

  def create
    load_product
    @rate = current_user.rates.build(rate_params)
    @rate.product_id = params[:product_id]
    if @rate.save
      update_avg_rating
    else
      flash[:danger] = t "products.err_cmt"
    end
    redirect_to @product
  end

  def update
    if @rate.update_attributes rate_params
      flash[:success] = t "products.success"
      update_avg_rating
    else
      flash[:fail] = t "flash.rate_fail"
    end
    redirect_to @product
  end

  private

  def rate_params
    params.require(:rate).permit :content, :rating
  end

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.product_not_found"
    redirect_to root_path
  end

  def load_rate
    @rates = @product.rates.find_by(id: params[:id])
    return if @rates

    flash[:danger] = t "products.product_not_found_rates"
    redirect_to root_path 
  end

  def update_avg_rating
    avg = Rate.cal_avg_rating(@product.id).to_f
    @product.update_attribute(:avg_rating, avg)
  end
end
