class PaymentsController < ApplicationController
  before_action :authenticate_user!, :only_admin
  before_action :load_payment, only: [:update, :destroy]
  before_action :allow_destroy, only: :destroy

  def index
    @payments = Payment.filter_by(params[:name]).paginate page: params[:page],
      per_page: Settings.items
    @payment = Payment.new
  end

  def create
    @payment = Payment.new name: params[:payment][:name]
    if @payment.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to payments_path
  end

  def update
    if @payment.update name: params[:payment][:name]
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

  def load_payment
    @payment = Payment.find_by id: params[:id]
    return if @payment
    flash[:danger] = t ".fail"
    redirect_to payments_path
  end

  def allow_destroy
    order_existing = @payment.orders
    return unless order_existing
    flash[:danger] = t ".fail"
    redirect_to payments_path
  end
end
