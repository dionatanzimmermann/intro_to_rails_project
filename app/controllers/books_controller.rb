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

# app/controllers/genres_controller.rb
class GenresController < ApplicationController
  def index
    @genres = Genre.all.order(name: :asc)
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books.includes(:reviews).page(params[:page]).per(12)
  end
end

# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def about
    @data_sources = [
      {
        name: "Open Library API",
        description: "Provides book metadata including titles, authors, and publication years.",
        structure: "JSON response with nested book data"
      },
      {
        name: "Faker Gem",
        description: "Generates fake user data and reviews for testing purposes.",
        structure: "Ruby objects with random data"
      },
      {
        name: "Custom CSV",
        description: "Contains genre information for categorizing books.",
        structure: "Simple CSV with name and description columns"
      }
    ]
  end
end