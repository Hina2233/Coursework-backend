class AddAdminUser < ActiveRecord::Migration[7.2]
  def up
    User.create!(
      first_name: "Admin",
      last_name: "User",
      email: "admin@example.com",
      password: "password123",
      password_confirmation: "password123",
      admin: true
    )
  end

  def down
    User.find_by(email: "admin@example.com")&.destroy
  end
end
