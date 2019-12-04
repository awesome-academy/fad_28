class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :only_admin, only: :index
  load_and_authorize_resource

  def index
    @search = User.ransack params[:q]
    @users = @search.result.paginate page: params[:page],
      per_page: Settings.items
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success"
      redirect_to users_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update profile_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to users_path
  end

  def evaluates
    evaluate = current_user.evaluates.includes(:product)
    @evaluates = evaluate.paginate page: params[:page], per_page: Settings.items
  end

  def suggests
    @search = current_user.suggests.ransack params[:q]
    @suggests = @search.result.paginate page: params[:page],
      per_page: Settings.items
  end

  def orders
    @orders = Order.newest.by_user(current_user.email).paginate page:
      params[:page], per_page: Settings.items
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :role_id,
      :password, :password_confirmation
  end

  def profile_params
    params.require(:user).permit :name, :gender, :phone, :address
  end
end
