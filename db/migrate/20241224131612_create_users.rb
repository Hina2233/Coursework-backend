class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :contact
      t.string :full_name

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
