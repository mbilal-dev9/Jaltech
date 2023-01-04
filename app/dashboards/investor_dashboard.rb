require "administrate/base_dashboard"

class InvestorDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String,
    user: Field::BelongsTo,
    person: Field::HasOne,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    user
    person
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    user
    person
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    user
    person
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
