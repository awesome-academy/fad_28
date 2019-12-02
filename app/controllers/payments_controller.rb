class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_payment, only: [:update, :destroy]
  before_action :allow_destroy, only: :destroy
  load_and_authorize_resource

  def index
    @search = Payment.ransack params[:q]
    @payments = @search.result.paginate page: params[:page],
      per_page: Settings.items
    @payment = Payment.new
  end

  def create
    @payment = Payment.new payment_params
    if @payment.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to payments_path
  end

  def update
    if @payment.update payment_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to payments_path
  end

  def destroy
    if @payment.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to payments_path
  end

  private

  def payment_params
    params.require(:payment).permit :name
  end

  def load_payment
    @payment = Payment.find_by id: params[:id]
    return if @payment
    flash[:danger] = t ".fail"
    redirect_to payments_path
  end

  def allow_destroy
    order_existing = @payment.orders
    return if order_existing.empty?
    flash[:danger] = t ".fail"
    redirect_to payments_path
  end
end
