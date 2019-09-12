class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @category = Category.find(params[:id])
    providercategories = ProviderCategory.where(category: @category)
    @providers = []
    providercategories.each do |provider_cat|
      @providers << provider_cat.provider
    end
    skip_authorization
    redirect_to "/results?utf8=✓&query=#{@category.name}"
  end
end
