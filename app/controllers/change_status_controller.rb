class ChangeStatusController < ApplicationController
  before_action :authenticate_user!, :only_admin, :load_order

  def update
    if @order.update_attribute :status_id, params[:status_id].to_i
      if @order.transport?
        @order.send_email_transporting
      elsif @order.finish?
        @order.send_email_finished
      end
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_back fallback_location: root_path
  end
end
