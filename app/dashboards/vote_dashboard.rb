require "administrate/base_dashboard"

class VoteDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    idea: Field::BelongsTo,
    user: Field::BelongsTo,
    vote_type: Field::Select.with_options(collection: Vote.vote_types.keys),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  COLLECTION_ATTRIBUTES = %i[
    id
    idea
    user
    vote_type
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    idea
    user
    vote_type
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  FORM_ATTRIBUTES = %i[
    idea
    user
    vote_type
  ].freeze

  # COLLECTION_FILTERS
  COLLECTION_FILTERS = {}.freeze
end
