class UsersController < ApplicationController
skip_before_action :authenticate_user!, only: [:show]
before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @user = current_user
    @reviews = @user.reviews
    authorize @user
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
    params.required(:user).permit(:first_name, :last_name, :email, :avatar)
  end

end
