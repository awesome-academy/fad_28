class AdminController < ApplicationController
  before_action :authenticate_user!, :only_admin

  def index; end
end
