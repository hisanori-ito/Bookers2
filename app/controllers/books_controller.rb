class BooksController < ApplicationController
  # ↓あとで削除
  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      redirect_to books_path(book.id)
      flash[:notice] = "You have created book successfully."
    else
      @books = Book.all
      @book_error = book
      @user_common = current_user
      @book_common = Book.new
      render :index
    end
  end

  def index
    @books = Book.all
    @book_error = Book.new
    @user_common = current_user
    @book_common = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user_common = @book.user
    @book_common = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(book.id)
    else
      @book = book
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.permit(:title, :body)
  end
end
