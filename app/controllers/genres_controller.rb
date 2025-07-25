class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  def index
    @genres = Genre.all.order(name: :asc)
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books.includes(:reviews).page(params[:page]).per(12)
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to genres_path, notice: 'Genre was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to genres_path, notice: 'Genre was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to genres_url, notice: 'Genre was successfully deleted.'
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :description)
  end
end