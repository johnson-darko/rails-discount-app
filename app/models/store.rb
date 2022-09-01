class Store < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :reviews

  validates :name, :address, :opening_hour, :closing_hour, presence: true
end
