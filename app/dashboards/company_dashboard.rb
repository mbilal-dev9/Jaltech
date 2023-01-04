require "administrate/base_dashboard"

class CompanyDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String,
    user: Field::BelongsTo,
    person: Field::HasOne,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    user
    person
    name
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    user
    person
    name
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    contact_person
    name
    user
    person
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
