class Admin::StatisticsController < ApplicationController
  before_action :check_loggin, :check_role_admin
  before_action :load_this_month, only: :index

  def index
    @users = User.group_by_week(:created_at)
    @users_activated = User.users_activated.size
    @chart_activated_user = User.group(:activated)
    @users_this_month = users_this_month.size
    @orders_this_month = orders_this_month.size
    @revenue = Order.revenue
    @revenue_this_month = orders_this_month.revenue
    @orders_bym = Order.group_by_month(:created_at)
    @orders_byd = orders_this_month.group_by_day(:created_at)
    @products = Product.all
    @stock_take = OrderItem.stock_take
    @stock_price = OrderItem.stock_take_price
    load_orders_fillter if params[:first] && params[:last]
  end

  def load_orders_fillter
    @fillter = Order.where(created_at: params[:first]..params[:last])
    @orders_fillter = @fillter.group_by_day(:created_at)
  end

  def users_this_month
    User.where(created_at: @date_end..@date_start)
  end

  def orders_this_month
    Order.where(created_at: @date_end..@date_start)
  end

  def load_this_month
    @date_start = DateTime.now
    @date_end = @date_start - Date.today.mday
  end

  def bestseller_this_month
    OrderItem.stock_take_desc.where(created_at: @date_end..@date_start)
  end
end
