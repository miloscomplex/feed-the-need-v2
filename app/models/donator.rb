class Donator < ApplicationRecord
  has_secure_password
  has_many :items
  # need to further explore utitizling source
  # has_many :donated_items, through: :items, source: :needy
  has_many :needy, through: :items

  validates :name, :email, :password, presence: true, on: :create
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :email_in_use
  validates :password, confirmation: true, on: :create

  private

  def email_in_use
    if Needy.find_by(email: self.email)
      errors.add(:email, "This is email is already registered as a person in need")
    end
  end

end
