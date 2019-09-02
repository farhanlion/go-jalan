class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_review, only: [:show]
  def index
    @reviews = Review.all
  end
  def show

  end

  private

  def set_review
    @review = Review.find(params[:id])
  end
end
