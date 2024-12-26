require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    first_name: Field::String,
    last_name: Field::String,
    full_name: Field::String,
    email: Field::String,
    contact: Field::String,
    role: Field::Select.with_options(
      collection: User.roles.keys.map { |role| [role.humanize, role] }
    ),  # Ensuring role is treated as a select field
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  COLLECTION_ATTRIBUTES = %i[
    id
    first_name
    last_name
    email
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    first_name
    last_name
    full_name
    email
    contact
    role
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  FORM_ATTRIBUTES = %i[
    first_name
    last_name
    full_name
    email
    contact
    role
  ].freeze

  # COLLECTION_FILTERS
  COLLECTION_FILTERS = {}.freeze

  def display_resource(user)
    "User ##{user.id} - #{user.full_name}"  # Customize how user is displayed
  end
end
