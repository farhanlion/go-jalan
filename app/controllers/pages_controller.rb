class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
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
end
