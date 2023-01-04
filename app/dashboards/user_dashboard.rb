require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String,
    advisor: Field::HasOne,
    allow_password_change: Field::Boolean,
    company: Field::HasOne,
    confirmation_sent_at: Field::DateTime,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    email: Field::String,
    encrypted_password: Field::String,
    investor: Field::HasOne,
    provider: Field::String,
    remember_created_at: Field::DateTime,
    reset_password_sent_at: Field::DateTime,
    reset_password_token: Field::String,
    tokens: Field::String.with_options(searchable: false),
    uid: Field::String,
    unconfirmed_email: Field::String,
    user_type: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    email
    created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    advisor
    allow_password_change
    company
    confirmation_sent_at
    confirmation_token
    confirmed_at
    email
    encrypted_password
    investor
    provider
    remember_created_at
    reset_password_sent_at
    reset_password_token
    tokens
    uid
    unconfirmed_email
    user_type
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    email
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
