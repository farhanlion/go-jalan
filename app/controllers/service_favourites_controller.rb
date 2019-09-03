class ServiceFavouritesController < ApplicationController
  def index
    @service_favourites = ServiceFavourite.all
  end

  def create
    @service_favourite = ServiceFavourite.new
    @service_favourite.service = @service
    @service_favourite.user = current_user
    @service_favourite.save
  end

  def destroy
    set_favourite
    @service_favourite.destroy!
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end
end
