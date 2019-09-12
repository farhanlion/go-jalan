class LikesController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @like = Like.find_by(review: @review, user: current_user)
    if @like.nil?
      @like = Like.new(review: @review, user: current_user)
      authorize @like
      @like.save
    else
      skip_authorization
      flash[:notice] = 'You have already liked this review.'
    end
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:id])
    @like = Like.find_by(review: @review, user: current_user)
    if @like.nil?
      skip_authorization
      flash[:notice] = 'You have already unliked this review.'
    else
      authorize @like
      @like.destroy
    end
    redirect_to review_path(@review)
  end
end
