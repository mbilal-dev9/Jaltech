require "administrate/base_dashboard"

class CryptocurrencyDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String,
    name: Field::String,
    category: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    code: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    name
    category
    code
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    category
    code
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    category
    code
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(cryptocurrency)
    cryptocurrency.name
  end
end
