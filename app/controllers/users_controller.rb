class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit]}
  before_action :ensure_current_user, {only: [:edit, :update]}

  def index
    @users = User.all
    @user_common = current_user
    @book_common = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id] )
    @user_common = @user
    @book_common = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @user_error = @user
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user.id)
      flash[:notice] = "You have updated user successfully."
    else
      @user_error = user
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_current_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user.id)
    end
  end
end
