class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_category, only: [:edit, :update, :destroy]
  before_action :allow_destroy, only: :destroy

  def index
    category = Category.includes(:products)
    @categories = category.filter(params[:name]).paginate page: params[:page],
      per_page: Settings.items
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to categories_path
      flash[:success] = t ".success"
    else
      render :new
    end
  end

  def update
    if @category.update category_params
      flash[:success] = t ".success"
      redirect_to categories_path
    else
      flash.now[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to categories_path
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".not_found"
    redirect_to categories_path
  end

  def category_params
    params.require(:category).permit :name, :parent_id
  end

  def allow_destroy
    exist_product = @category.products
    return if exist_product.empty?
    flash[:danger] = t ".can't_delete"
    redirect_to categories_path
  end
end
