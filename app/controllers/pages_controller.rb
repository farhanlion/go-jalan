class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def results
    @reviews = Review.global_search(params[:query])
    @providers = Provider.global_search(params[:query])
    @providers = Provider.all if @providers.empty?
    @reviews = Review.all if @reviews.empty?
  end

  def nearby
    @providers = policy_scope(Provider)
    @favourite = Favourite.new
    @markers = @providers.map do |provider|
      {
        lat: provider.latitude,
        lng: provider.longitude
      }
    end
  end

  def results_tags
  end
end
