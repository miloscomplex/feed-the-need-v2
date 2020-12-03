class Donator < ApplicationRecord
  has_secure_password

  validates :name, :email, presence: true
  validates :password, confirmation: true 

end
