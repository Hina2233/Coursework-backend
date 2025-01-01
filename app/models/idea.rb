class Idea < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :region, presence: true
  validates :description, presence: true

  # Boolean flag to mark an idea as shortlisted (favorite)
  attribute :is_shortlisted, :boolean, default: false

  # Count upvotes and downvotes
  def upvotes_count
    votes.where(vote_type: :up).count
  end

  def downvotes_count
    votes.where(vote_type: :down).count
  end

  # Toggle the shortlisted status
  def toggle_shortlisted!
    update(is_shortlisted: !is_shortlisted)
  end

  def approve!
    update(approved: true)
  end

  def decline!
    update(approved: false)
  end
end
