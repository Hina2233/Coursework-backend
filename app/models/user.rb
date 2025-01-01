class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Enum for role management
  enum role: { employee: 'employee', manager: 'manager', admin: 'admin' }

  # Associations
  has_many :ideas
  has_many :votes
  has_many :comments

  # Callback to set full name
  before_save :set_full_name

  def manager?
    role == 'manager'
  end

  def set_full_name
    self.full_name = "#{first_name} #{last_name}"
  end

  # Helper method to return the display name
  def display_name
    full_name.presence || email
  end

  # Check if the user has an admin role
  def admin?
    role == 'admin'
  end
end
