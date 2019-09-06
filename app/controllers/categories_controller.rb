class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    providercategories = ProviderCategory.where(category: @category)
    @providers = []
    providercategories.each do |provider_cat|
      @providers << provider_cat.provider
    end
    skip_authorization
  end
end
