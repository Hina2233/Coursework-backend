require "administrate/base_dashboard"

class IdeaDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    comments: Field::HasMany,
    description: Field::Text,
    title: Field::String,
    user: Field::BelongsTo,
    votes: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    is_shortlisted: Field::Boolean, # Field for shortlisted status
    approved: Field::Boolean, # Field for shortlisted status
    upvotes_count: Field::Number, # Display the upvotes count
    downvotes_count: Field::Number # Display the downvotes count
  }.freeze

  # COLLECTION_ATTRIBUTES
  COLLECTION_ATTRIBUTES = %i[
    id
    title
    description
    is_shortlisted
    approved
    upvotes_count
    downvotes_count
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  title
  description
  user
  comments
  upvotes_count
  downvotes_count
  is_shortlisted
  approved
  created_at
  updated_at
].freeze

  # FORM_ATTRIBUTES
  FORM_ATTRIBUTES = %i[
  title
  description
  user
  is_shortlisted
  approved
].freeze

  # CUSTOM METHODS
  def upvotes_count(idea)
    idea.upvotes_count
  end

  def downvotes_count(idea)
    idea.downvotes_count
  end

  def display_resource(idea)
    "Idea ##{idea.id} - #{idea.title}"
  end
end
