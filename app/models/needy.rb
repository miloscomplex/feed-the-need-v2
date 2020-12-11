class Needy < ApplicationRecord
  has_secure_password

  has_many :items
  has_many :donators, through: :items


  validates :name, :email, presence: true
  validates :password, presence: true, on: :create 
  validates :email, uniqueness: true
end
