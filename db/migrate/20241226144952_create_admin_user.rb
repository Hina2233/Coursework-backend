class CreateAdminUser < ActiveRecord::Migration[7.2]
  def change
    # Add a default admin user with credentials
    User.create!(
      first_name: "Super",
      last_name: "Admin",
      email: "superadmin@example.com",
      password: "Change@Me", # Use a secure password in production
      password_confirmation: "Change@Me",
      role: "admin"
    )
  end
end
