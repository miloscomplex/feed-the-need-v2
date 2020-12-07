class Item < ApplicationRecord

  has_many :needies
  has_many :donators

  validates :name, :quantity, presence: true

end
