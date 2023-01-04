require "administrate/base_dashboard"

class ProductDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String,
    name: Field::String,
    description: Field::Text,
    category: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    cryptocurrencies: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    name
    description
    cryptocurrencies
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    description
    cryptocurrencies
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    description
    cryptocurrencies
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
