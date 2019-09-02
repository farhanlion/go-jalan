class ProviderFavouritesController < ApplicationController
  def index
    @provider_favourites = ProviderFavourite.all
  end

  def create
    @provider_favourite = ProviderFavourite.new
    @provider_favourite.provider = @provider
    @provider_favourite.user = current_user
    @provider_favourite.save
  end

  def destroy
    set_favourite
    @provider_favourite.destroy!
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end
end
