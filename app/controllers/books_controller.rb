class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @genres = Genre.all
    @books = Book.includes(:genre, :reviews)
    if params[:genre_id].present?
      @books = @books.where(genre_id: params[:genre_id])
    end
    @books = @books.where("title LIKE ? OR author LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    @books = @books.order(title: :asc).page(params[:page]).per(12)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.includes(:user).order(created_at: :desc)
    @reviews = @book.reviews.includes(:user).page(params[:page]).per(5)
    @review = Review.new
  end

  def new
    @book = Book.new
  end

   def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully deleted.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :published_year, :isbn, :description, :genre_id)
  end
end



