class ChangeStatusController < ApplicationController
  before_action :signed_in, :load_order

  def update
    if @order.update_attribute :status_id, params[:status_id].to_i
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to orders_path
  end
end
