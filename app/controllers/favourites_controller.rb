class FavouritesController < ApplicationController
  # before_action :set_favourite, only: [:destroy]

  def index
    @favs = policy_scope(Favourite)
    @favs = Favourite.all
  end

  def create
    @fav = Favourite.new(provider: Provider.find(params[:provider_id]), user: current_user)
    authorize @fav
    @fav.save!
    redirect_to providers_path
  end

  def destroy
    @provider = Provider.find(params[:id])
    @fav = Favourite.find_by(provider: @provider)
    if @fav.nil?
      skip_authorization
      flash[:notice] = 'You have already unliked this review.'
    else
      authorize @fav
      @fav.destroy
    end
    redirect_to providers_path
  end

  private

  def set_favourite
    @fav = Favourite.find(params[:id])
  end
end
