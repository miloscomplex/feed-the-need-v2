class Needy < ApplicationRecord
  has_secure_password

  has_many :items
  has_many :donators, through: :items


  validates :name, :email, :bio, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, on: :create

  def first_name
    first_name = self.name.split(/ /)
    first_name.first
  end

end
