# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'httparty'
require 'csv'

# Clear existing data
[Genre, Book, User, Review].each(&:destroy_all)

# 1. Seed Genres from CSV
csv_text = File.read(Rails.root.join('lib', 'seeds', 'genres.csv'))
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Genre.create!(name: row['name'], description: row['description'])
end

# 2. Seed Books from Open Library API
genres = Genre.all
(1..5).each do |i|
  response = HTTParty.get("https://openlibrary.org/search.json?q=#{Faker::Book.genre.downcase.gsub(' ', '+')}&limit=10&page=#{i}")
  books_data = JSON.parse(response.body)['docs']

  books_data.each do |book_data|
    next unless book_data['title'] && book_data['author_name'] && book_data['first_publish_year']

    Book.create!(
      title: book_data['title'],
      author: book_data['author_name'].first,
      published_year: book_data['first_publish_year'],
      isbn: book_data['isbn']&.first,
      description: book_data['subject']&.join(', '),
      genre: genres.sample
    )
  end
end

# 3. Seed Users and Reviews using Faker
50.times do
  user = User.create!(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email
  )

  Book.all.sample(rand(1..5)).each do |book|
    Review.create!(
      rating: rand(1..5),
      content: Faker::Lorem.paragraph(sentence_count: 3),
      book: book,
      user: user
    )
  end
end

puts "Created #{Genre.count} genres, #{Book.count} books, #{User.count} users, and #{Review.count} reviews"