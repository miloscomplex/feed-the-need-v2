class Needy < ApplicationRecord
  has_secure_password

  has_many :items
  has_many :donators, through: :items


  validates :name, :email, :bio, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validate :email_in_use
  validates :password, presence: true, on: :create

  def first_name
    first_name = self.name.split(/ /)
    first_name.first
  end

  private
  
  def email_in_use
    if Donator.find_by(email: self.email)
      errors.add(:email, "This is email is already registered as a Donator")
    end
  end

end
