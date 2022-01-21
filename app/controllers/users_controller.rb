class UsersController < ApplicationController

  def index
    @users = User.all
    @user_common = current_user
    @book_common = Book.new
  end

  def show
    @user = User.find(params[:id])
    @user_common = current_user
    @books = Book.all
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
    else
      @user_error = user
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
