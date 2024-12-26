require "administrate/base_dashboard"

class CommentDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    content: Field::Text,
    idea: Field::BelongsTo.with_options(searchable: true, searchable_field: "title"),
    user: Field::BelongsTo.with_options(searchable: true, searchable_field: "email"),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    content
    idea
    user
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    content
    idea
    user
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    content
    idea
    user
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(comment)
    "Comment ##{comment.id} - #{comment.content.truncate(30)}"
  end
end
