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
end
