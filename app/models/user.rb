class User < ApplicationRecord
  has_many :ideas
  has_many :votes
  has_many :comments
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Validations
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :contact, presence: true, format: { with: /\A\d{10,15}\z/, message: "must be a valid phone number with 10-15 digits" }

  # Helper Methods
  before_save :set_full_name

  def set_full_name
    self.full_name = "#{first_name} #{last_name}"
  end

  def display_name
    full_name.presence || email
  end
end
