class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:show, :new]
  def index
    @reviews = policy_scope(Review)
  end

  def show
    @review = Review.find(params[:id])
    @next = @review.next
    @previous = @review.previous
    authorize @review
  end

  def new
    @provider = Provider.new
    @provider = Provider.find(params[:provider_id]) unless params[:provider_id].nil?
    @user = current_user
    @review = Review.new
    skip_authorization
  end

  def new_no_provider
    @user = current_user
    @provider = Provider.new
    @review = Review.new
    skip_authorization
    render 'reviews/new_review'
  end

  def create
    if params[:provider_id].nil?
      @provider = Provider.find(params[:review][:provider_id])
      @review = Review.new(review_params)
      @review.user = current_user
      @review.provider = @provider
    else
      @provider = Provider.find(params[:provider_id])
      @review = Review.new(review_params)
      @review.user = current_user
      @review.provider = @provider
    end
    authorize @review
    if @review.save
      if params[:review][:photo_url].nil?
      else
        params[:review][:photo_url].each do |photo|
          ReviewPhoto.create(photo_url: photo, review: @review)
        end
      end
      @provider.add_rating
      redirect_to @provider
    else
      render :new_no_provider if params[:provider_id].nil?
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
    @review.review_photos.each do |photo|
      photo.destroy
    end
    @review.provider.delete_rating(@review)
    @review.destroy
    redirect_to @review.provider
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.required(:review).permit(:title, :content, :rating )
  end
end
