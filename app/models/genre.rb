class Genre < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 50 }
  validates :description, length: { maximum: 500 }
end