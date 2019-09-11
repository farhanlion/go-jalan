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
    render do |format|
      format.js
    end
  end

  def destroy
    @fav = Favourite.find(params[:id])
    @provider = @fav.provider
    if @fav.nil?
      skip_authorization
      flash[:notice] = 'You have already unliked this review.'
    else
      authorize @fav
      @fav.destroy
    end
    render do |format|
      format.js
    end
  end

  private

  def set_favourite
    @fav = Favourite.find(params[:id])
  end
end
