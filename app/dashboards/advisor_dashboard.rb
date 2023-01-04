require "administrate/base_dashboard"

class AdvisorDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String,
    user: Field::BelongsTo,
    person: Field::HasOne,
    company_name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    user
    person
    company_name
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    user
    person
    company_name
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    company_name
    user
    person
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
