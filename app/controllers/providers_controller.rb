class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_provider, only: [:show]
  skip_after_action :verify_authorized, only: [:show, :new]
  def index
    @providers = policy_scope(Provider)
    if !params[:query]
      @providers
    else
      @providers = @providers.search_by_name_and_description_and_street_address_and_district_and_country(params[:query])
    end
  end

  def show
    skip_authorization
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end
end
