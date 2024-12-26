class Vote < ApplicationRecord
  belongs_to :idea
  belongs_to :user

  enum vote_type: { down: 0, up: 1 }

  # Validations
  validates :vote_type, inclusion: { in: vote_types.keys }
end
