class Admin::StatisticsController < ApplicationController
  authorize_resource class: false

  def index
    unless params[:first] && params[:last]
      @users = User.all
      @orders = Order.all
    end
    if params[:first]
      @users = User.date_start(params[:first]).asc_name
      @orders = Order.date_start(params[:first]).oldest_time
    end
    if params[:last]
      @users = User.date_end(params[:last]).asc_name
      @orders = Order.date_end(params[:last]).oldest_time
    end
  end
end
