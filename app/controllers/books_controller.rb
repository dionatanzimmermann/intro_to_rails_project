class BooksController < ApplicationController
  def index
    @books = Book.includes(:genre, :reviews)
    @books = @books.where("title LIKE ? OR author LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    @books = @books.order(title: :asc).page(params[:page]).per(12)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.includes(:user).page(params[:page]).per(5)
  end
end