class Item < ApplicationRecord

  validates :name, :quantity, presence: true

end
