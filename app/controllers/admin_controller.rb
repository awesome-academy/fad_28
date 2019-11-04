class AdminController < ApplicationController
  before_action :only_admin

  def index; end
end
