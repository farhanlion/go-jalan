class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_review, only: [:show]
  def index
    @reviews = Review.all
  end
  def show

  end

  def new
    @provider = Provider.find(params[:provider_id]) unless params[:provider_id].nil?
    @service = Service.find(params[:service_id]) unless params[:service_id].nil?
    @provider = @service.provider if @service
    @review = Review.new
    @user = current_user
  end

  def create
    @provider = Provider.find(params[:provider_id]) unless params[:provider_id].nil?
    @service = Service.find(params[:service_id]) unless params[:service_id].nil?
    @provider = @service.provider if @service
    @review = Review.new(review_params)
    @review.user = current_user
    @review.provider = @provider
    @review.service = @service
    if @review.save
      redirect_to @provider
    else
      render :new
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.required(:review).permit(:title, :content, :rating)
  end
end
