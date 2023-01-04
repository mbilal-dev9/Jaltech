require "administrate/base_dashboard"

class PersonDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    title: Field::String,
    nationality: Field::String,
    country_of_birth: Field::String,
    place_of_birth: Field::String,
    rsa_number: Field::String,
    email: Field::String,
    phone_no: Field::String,
    employer: Field::String,
    occupation: Field::String,
    employment_nature: Field::String,
    job_title: Field::String,
    previous_employment: Field::String,
    occupation_jurisdiction: Field::String
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    first_name
    last_name
    title
    nationality
    country_of_birth
    place_of_birth
    rsa_number
    email
    phone_no
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    first_name
    last_name
    created_at
    updated_at
    title
    nationality
    country_of_birth
    place_of_birth
    rsa_number
    email
    phone_no
    employer
    occupation
    employment_nature
    job_title
    previous_employment
    occupation_jurisdiction
  ].freeze

  FORM_ATTRIBUTES = %i[
    first_name
    last_name
    title
    nationality
    country_of_birth
    place_of_birth
    rsa_number
    email
    phone_no
    employer
    occupation
    employment_nature
    job_title
    previous_employment
    occupation_jurisdiction
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
