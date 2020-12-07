class Donator < ApplicationRecord
  has_secure_password
  has_many :items
  has_many :needy, through: :items

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

end
