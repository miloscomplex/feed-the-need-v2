class Item < ApplicationRecord

  belongs_to :needy
  has_many :donators

  validates :name, :quantity, presence: true

end
