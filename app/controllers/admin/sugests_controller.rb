class Admin::SugestsController < ApplicationController
  before_action :check_loggin, :check_role_admin
  before_action :load_sugest, only: %i(update create_category create_product)
  
  def index
    @sugest = Sugest.order_by_created.paginate(page: params[:page],
      per_page: Settings.pages.per_page_ten)
  end

  def new; end

  def show;
  redirect_to admin_sugests_path
  end

  def create
    create_product
  end
  
  def update
    if params[:status] == Settings.label.accept
      case @sugest.status
      when Settings.label.default_create
        accept
        @sugest.accept!
        return render :new
      when Settings.label.new_cate
        flash[:info] = t "controllers.admin.sugests.cate_fisrt",
          name: @sugest.new_category
      when Settings.label.accept
        flash[:info] = t "controllers.admin.sugests.sug_done"
      when Settings.label.refuse
        flash[:info] = t "controllers.admin.sugests.refuse"
      else
        flash[:info] = t "controllers.admin.sugests.err"
      end
      redirect_to admin_sugests_path
    elsif params[:status] == Settings.label.refuse
      case @sugest.status
      when Settings.label.accept
        flash[:info] = t "controllers.admin.sugests.sug_done"
      else
        refuse
      end
    elsif params[:status] == Settings.label.new_cate
      case @sugest.status
      when Settings.label.accept
        flash[:info] = t "controllers.admin.sugests.sug_done"
      else
        @category = Category.new name: @sugest.new_category
        @sugest.default_create!
        return render "categories/new"
      end
      redirect_to admin_sugests_path
    else
      flash[:info] = t "controllers.admin.sugests.err"
      redirect_to admin_sugests_path
    end
    rescue NoMethodError => e
      flash[:danger] = t "controllers.admin.sugests.bug_update", name: e.message
    redirect_to admin_sugests_path
  end
  
  private

  def accept
    @product = Product.new name: @sugest.name, description: @sugest.description,
      category_id: @sugest.category_id
  end

  def refuse
    @sugest.refuse!
    flash[:info] = t "controllers.admin.sugests.refuse_success"
    redirect_to admin_sugests_path
  end
  
  def load_sugests
    @sugests = Sugest.all
    return if @sugests
    flash[:info] = t "controllers.admin.sugests.not_found"
    redirect_to admin_products_path
  end

  def load_sugest
    @sugest = Sugest.find_by id: params[:id]
    return if @sugest
    flash[:info] = t "controllers.admin.sugests.not_found"
    redirect_to admin_sugests_path
  end

  def params_product
    params.require(:product).permit :name, :price, :quantity, :description,
      :picture, :category_id
  end

  def params_category
    params.require(:category).permit :name
  end

  def create_category
    @category = Category.new params_category
    if @category.save
      @sugest.default_create!
      flash[:success] = t "controllers.admin.sugest.cate_success"
      
    else
      return render :category
    end
  end

  def create_product
    @product = Product.new params_product
      if @product.save
        flash[:success] = t "controllers.product.success"
        redirect_to admin_sugests_path
      else
        return render :new
      end
  end
end
