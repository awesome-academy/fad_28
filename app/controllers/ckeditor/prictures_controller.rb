class Ckeditor::PricturesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create, raise: false

  def index
    @pictures = Ckeditor.picture_adapter.find_all ckeditor_pictures_scope
    @pictures = Ckeditor::Paginatable.new(@pictures).page params[:page]
    respond_to do |format|
      format.html{render layout: @pictures.first_page?}
    end
  end

  def create
    @picture = Ckeditor.picture_model.new
    respond_with_asset @picture
  end

  def destroy
    respond_to do |format|
      if @picture.destroy
        format.json{render json: @picture, status: 204}
      else
        format.json{render json: @picture, status: :unprocessable_entity}
      end
      format.html{redirect_to pictures_path}
    end
  end

  private

  def find_asset
    @picture = Ckeditor.picture_adapter.get! params[:id]
  end

  def authorize_resource
    model = @picture || Ckeditor.picture_model
    @authorization_adapter.try :authorize, params[:action], model
  end
end
