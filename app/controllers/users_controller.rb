class UsersController < ApplicationController
skip_before_action :authenticate_user!, only: [:show]
before_action :set_user, only: [:edit, :update, :destroy]

  def profile
    @user = current_user
    @reviews = @user.reviews
    @providers = @user.favourites.map do |fav|
      fav.provider
    end
    authorize @user
  end

  def show
    skip_authorization
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      if @user == current_user
        redirect_to profile_path
      end
      @reviews = Review.where(user: params[:id])
    else
      redirect_to root_path
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    @user.update(user_params)
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.required(:user).permit(:first_name, :last_name, :description, :email, :avatar)
  end
end
