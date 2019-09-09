class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :nearby, :results]
  before_action :loc

  def home
    @reviews = Review.best
  end

  def results
    @reviews = Review.global_search(params[:query])
    @providers = Provider.global_search(params[:query])
    @providers = Provider.all if @providers.empty?
    @reviews = Review.all if @reviews.empty?
  end

  def nearby
    @providers = policy_scope(Provider)
    @loc = Geocoder.search("Orchard Road, Singapore").first.coordinates if @loc == []
    @providers = @providers.near(@loc, 1, units: :km)
    @favourite = Favourite.new
    @markers = @providers.map do |provider|
      {
        lat: provider.latitude,
        lng: provider.longitude,
        infoWindow: render_to_string(partial: "components/map_popup", locals: { provider: provider })

      }
    end
  end

  def activity
    @likes = current_user.likes
    @favs = current_user.favourites
  end

  def loc
    if request.location
      result = request.location
      @loc = result.coordinates
    else
      @loc = Geocoder.search("Orchard Road, Singapore").first.coordinates
    end
  end

  def results_tags
  end
end
