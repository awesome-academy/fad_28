class EvaluatesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_data, only: :create
  before_action :load_evaluate, except: :create
  before_action :load_product, only: [:update, :destroy]

  def edit; end

  def create
    if @evaluate.save
      respond_to do |format|
        format.html{redirect_to product_path(@product)}
        @evaluate = Evaluate.new
        format.js
      end
    else
      flash[:danger] = t ".fail"
      redirect_to product_path @product
    end
  end

  def update
    if @evaluate.update evaluate_params
      flash[:success] = t ".success"
      redirect_to product_path @product
    else
      flash.now[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @evaluate.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to product_path @product
  end

  private

  def evaluate_params
    params.require(:evaluate).permit :star, :content, :product_id
  end

  def load_product
    @product = Product.find_by id: @evaluate.product_id
    return if @product
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def load_evaluate
    @evaluate = Evaluate.find_by id: params[:id]
    return if @evaluate
    flash[:danger] = t ".fail"
    redirect_to product_path @product
  end

  def load_data
    @product = Product.find_by id: params[:evaluate][:product_id]
    @evaluates = @product.evaluates.recently.paginate page: params[:page],
      per_page: Settings.items
    @evaluate = current_user.evaluates.new evaluate_params
  end
end
