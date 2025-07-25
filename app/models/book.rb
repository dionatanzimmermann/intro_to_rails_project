class Book < ApplicationRecord
  belongs_to :genre
  has_many :reviews, dependent: :destroy
  validates :title, :author, :published_year, presence: true
  validates :isbn, uniqueness: true, allow_blank: true
end