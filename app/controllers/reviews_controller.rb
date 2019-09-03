class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:show, :new]
  def index
    @reviews = policy_scope(Review)
    raise
    if !params[:query]
      @reviews
    else
      @reviews = @reviews.global_search(params[:query])
    end
  end

  def show
    authorize @review
  end

  def new
    @provider = Provider.find(params[:provider_id]) unless params[:provider_id].nil?
    @user = current_user
    @review = Review.new
  end

  def create
    @provider = Provider.find(params[:provider_id]) unless params[:provider_id].nil?
    @review = Review.new(review_params)
    @review.user = current_user
    @review.provider = @provider

    authorize @review
    if @review.save
      redirect_to @provider
    else
      render :new
    end
  end

  def edit
    @provider = @review.provider
    authorize @review
  end

  def update
    authorize @review
    @review.update(review_params)
    redirect_to @review.provider
  end

  def destroy
    authorize @review
    @review.destroy
    redirect_to @review.provider
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.required(:review).permit(:title, :content, :rating)
  end
end
