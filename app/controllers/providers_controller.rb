class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_provider, only: [:show]
  skip_after_action :verify_authorized, only: [:show, :new]
  def index
    @providers = policy_scope(Provider)
    if !params[:query]
      @providers
    else
      @providers = @providers.global_search(params[:query])
    end
    @favourite = Favourite.new
    @markers = @providers.map do |provider|
      {
        lat: provider.latitude,
        lng: provider.longitude
      }
    end
  end

  def show
    skip_authorization
    @markers =
      {
        lat: @provider.latitude,
        lng: @provider.longitude
      }
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end
end
