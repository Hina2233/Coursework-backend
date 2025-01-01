class AddColaborativeToIdeas < ActiveRecord::Migration[7.2]
  def change
    add_column :ideas, :colaborative, :boolean, default:false
  end
end
