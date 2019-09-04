class FavouritesController < ApplicationController
  before_action :set_favourite, only: [:destroy]

  def index
    @favs = policy_scope(Favourite)
    @favs = Favourite.all
  end

  def create
    @fav = Favourite.new(provider: Provider.find(params[:provider_id]), user: current_user)
    authorize @fav
    @fav.save!
    redirect_to favourites_path
  end

  def destroy
    authorize @fav
    @fav.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_favourite
    @fav = Favourite.find(params[:id])
  end
end
