class GenresController < ApplicationController
  def index
    @genres = Genre.all.order(name: :asc)
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books.includes(:reviews).page(params[:page]).per(12)
  end
end