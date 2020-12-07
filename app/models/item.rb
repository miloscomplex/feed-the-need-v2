class Item < ApplicationRecord

  belongs_to :needy
  belongs_to :donator 

  validates :name, :quantity, presence: true

end
