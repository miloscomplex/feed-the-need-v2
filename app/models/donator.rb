class Donator < ApplicationRecord
  has_secure_password
  has_many :items
  # need to further explore utitizling source
  # has_many :donated_items, through: :items, source: :needy
  has_many :needy, through: :items 

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

end
