class SuggestsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  before_action :load_suggest, except: [:index, :new, :create, :admin_view_new]

  def index
    @search = Suggest.includes(:user).ransack params[:q]
    @suggests = @search.result.newest.paginate page: params[:page],
      per_page: Settings.items
  end

  def show; end

  def new
    @suggest = Suggest.new
  end

  def create
    @suggest = current_user.suggests.new suggest_params
    if @suggest.save
      flash[:success] = t ".success"
      redirect_to @suggest
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def edit; end

  def update
    if @suggest.update suggest_params
      flash[:success] = t ".success"
      redirect_to @suggest
    else
      flash[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to suggests_path
  end

  def admin_view_new
    @suggests = Suggest.not_seen.includes(:user).paginate page: params[:page],
      per_page: Settings.items
  end

  def admin_seen
    @suggest.update_attribute :admin_seen, true
    redirect_to @suggest
  end

  private

  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    return if @suggest
    flash[:danger] = t ".not_found"
    redirect_to suggests_path
  end

  def suggest_params
    params.require(:suggest).permit :product_name, :image, :description
  end
end
