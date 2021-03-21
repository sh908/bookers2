class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book, only:[:edit ]

  def index
    @books=Book.all
    @book=Book.new
    @user=current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:success] = "successfully"
      redirect_to book_path(@book)
    else
       @user = current_user
       @books= Book.all
       render :index
    end
  end

  def edit
  end

  def show
    @book_new=Book.new
    @book=Book.find(params[:id])
    @user=@book.user
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:success] = "successfully"
       redirect_to book_path(@book)
    else
       render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_book
       @book = Book.find(params[:id])
    if @book.user.id != current_user.id
       redirect_to books_path
    end
  end
end
