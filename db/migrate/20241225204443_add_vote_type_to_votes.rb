class AddVoteTypeToVotes < ActiveRecord::Migration[7.2]
  def change
    add_column :votes, :vote_type, :integer
  end
end
