class Admin::StatisticsController < ApplicationController
  before_action :check_loggin, :check_role_admin
  before_action :users_this_month,  :orders_this_month,
    :load_orders_fillter, only: :index

  def index
    @users = User.group_by_week :created_at
    @users_activated = User.users_activated.size
    @chart_activated_user = User.group :activated
    @users_this_month = users_this_month.size
    @orders_this_month = orders_this_month.size
    @revenue = Order.revenue
    @revenue_this_month = orders_this_month.revenue
    @orders_bym = Order.group_by_month :created_at
    @orders_byd = orders_this_month.group_by_day :created_at
    @stock_take = OrderItem.stock_take
    @stock_price = OrderItem.stock_take_price
    @stockq = @stock_take.sort_by{|a, b, c| -b}
    @stock_quantiy = @stockq.take(5)
    @stockp = @stock_take.sort_by{|a, b, c| -c}
    @stock_pr = @stockp.take(5)
    load_orders_fillter if params[:first] && params[:last]
  end

  def load_orders_fillter
    Order.date_start(params[:first]).date_end(params[:last])
      .group_by_day(:created_at)
  end

  def users_this_month
    User.date_start(DateTime.now - Date.today.mday)
      .date_end(DateTime.now)
      .group_by_day(:created_at)
  end

  def orders_this_month
    Order.date_start(DateTime.now - Date.today.mday)
      .date_end(DateTime.now)
      .group_by_day(:created_at)
  end
end
