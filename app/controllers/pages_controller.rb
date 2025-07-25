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