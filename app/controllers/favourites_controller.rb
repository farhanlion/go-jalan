class FavouritesController < ApplicationController
  # before_action :set_favourite, only: [:destroy]

  def index
    @user = current_user
    @favs = policy_scope(Favourite)
    @favs = Favourite.where(user: current_user)
  end

  def create
    @fav = Favourite.new(provider: Provider.find(params[:provider_id]), user: current_user)
    authorize @fav
    @fav.save!
    redirect_to @fav.provider
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
    redirect_to @provider
  end

  private

  def set_favourite
    @fav = Favourite.find(params[:id])
  end
end
