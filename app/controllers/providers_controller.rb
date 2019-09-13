class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_provider, only: [:show]
  skip_after_action :verify_authorized, only: [:show, :new]

  def index
    @providers = policy_scope(Provider)
    @favourite = Favourite.new()
    @markers = @providers.map do |provider|
      {
        lat: provider.latitude,
        lng: provider.longitude,
        infoWindow: render_to_string(partial: "components/map_popup", locals: { provider: provider })
      }
    end
  end

  def show
    skip_authorization
    @markers =
      [{
        lat: @provider.latitude,
        lng: @provider.longitude,
        infoWindow: render_to_string(partial: "components/map_popup", locals: { provider: @provider })
      }]
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end
end
