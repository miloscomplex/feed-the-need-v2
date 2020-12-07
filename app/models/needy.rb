class Needy < ApplicationRecord
  has_secure_password

  has_many :items
  has_many :donators, through: :items


  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
end
