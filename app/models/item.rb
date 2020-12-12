class Item < ApplicationRecord

  belongs_to :needy
  has_many :donators

  validates :name, :quantity, presence: true

  def find_donator
    Donator.find_by(id: self.donator_id) unless self.donator_id.nil?
  end
end
