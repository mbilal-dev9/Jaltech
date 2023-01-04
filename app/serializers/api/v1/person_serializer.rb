# frozen_string_literal: true

module Api
  module V1
    class PersonSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name, :email, :phone_no, :title, :residential_status, :nationality, :country_of_birth, :place_of_birth,
        :rsa_number, :foreign_id, :sa_tax_number, :occupation, :occupation_jurisdiction, :job_title, :employer, :employment_nature, :previous_employment
    end
  end
end
