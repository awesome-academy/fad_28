class UsersController < ApplicationController
  before_action :allow_signup, only: [:new, :create]
  before_action :signed_in, except: [:new, :create]
  before_action :only_admin, only: [:index, :destroy]
  before_action :load_user, only: [:show, :update, :destroy]
  before_action :correct_user, only: [:show, :update]
  before_action :load_evaluates, only: :show

  def index
    @users = User.filter_by(params[:name]).paginate page: params[:page],
      per_page: Settings.items
  end

  def show
    @orders = Order.newest.by_user(current_user.email).paginate page:
      params[:page], per_page: Settings.items
    @finished = Order.finish.by_user current_user.email
    @counts = 0
    @finished.each{|order| @counts += order.order_items.sum :quantity}
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      if current_user&.admin?
        flash[:success] = t ".success"
        return redirect_to users_path
      end
      signin @user
      redirect_to @user
      flash[:success] = t ".saved"
    else
      render :new
    end
  end

  def update
    @user.save context: :skip
    if @user.update profile_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".fail"
      render :show
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

  private

  def user_params
    params.require(:user).permit :email, :name,
      :password, :password_confirmation
  end

  def profile_params
    params.require(:user).permit :name, :gender, :phone, :address
  end

  def correct_user
    return if current_user == @user
    redirect_to current_user
  end

  def load_evaluates
    evaluate = current_user.evaluates.includes(:product)
    @evaluates = evaluate.paginate page: params[:page], per_page: Settings.items
  end
end
