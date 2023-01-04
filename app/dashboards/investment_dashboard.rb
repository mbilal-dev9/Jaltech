require "administrate/base_dashboard"

class InvestmentDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String,
    profile: Field::Polymorphic,
    product: Field::BelongsTo,
    amount_cents: Field::Number.with_options(prefix: "$", decimals: 2)
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    profile
    product
    amount_cents
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    profile
    product
    amount_cents
  ].freeze

  FORM_ATTRIBUTES = %i[
    amount_cents
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
