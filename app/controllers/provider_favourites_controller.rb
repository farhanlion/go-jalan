class ProviderFavouritesController < ApplicationController
  # before_action :set_provider, only: [:create, :destroy]
  # before_action :set_favourite, only: [:create, :destroy]
  def index
    @favs = policy_scope(ProviderFavourite)
    @favs = ProviderFavourite.all
  end

  def create
    @favourite = ProviderFavourite.new
    @provider_favourite.provider = @provider
    @provider_favourite.user = current_user
    @provider_favourite.save
  end

  def destroy
    set_favourite
    @provider_favourite.destroy!
  end

  private

  # def set_provider
  #   @provider = Provider.find(params[:id])
  # end

  # def set_favourite
  #   @fav = ProviderFavourite.find(params[:])
  # end
end
