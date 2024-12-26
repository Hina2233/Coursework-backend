class AddApprovedToIdeas < ActiveRecord::Migration[7.2]
  def change
    add_column :ideas, :approved, :boolean,default:false
    add_column :ideas, :is_shortlisted, :boolean,default:false
  end
end
