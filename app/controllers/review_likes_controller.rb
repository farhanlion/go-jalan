class ReviewLikesController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review_like = ReviewLike.new(review: @review, user: current_user)
    authorize @review_like
    @review_like.save
    redirect_to provider_path(@review.provider)
  end

  def destroy
    @review = Review.find(params[:id])
    @review_like = @review.review_likes.find_by(user: current_user)
    authorize @review_like
    @review_like.destroy
    redirect_to provider_path(@review.provider)
  end

end
