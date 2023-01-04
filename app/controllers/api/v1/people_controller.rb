# frozen_string_literal: true

module Api
  module V1
    class PeopleController < Api::ApiController
      before_action :authenticate_user!
      def update
        if person.update(person_params)
          render_ok(serialize(person,
            serializer: ::Api::V1::PersonSerializer))
        else
          render_unprocessable_entity(person.errors)
        end
      end

      private

      def person
        @person ||= current_user.profile.person
      rescue ActiveRecord::RecordNotFound => e
        render_not_found(e)
      end

      def person_params
        params.require(:person).permit(
          :first_name, :last_name, :title, :residential_status, :nationality,
          :country_of_birth, :place_of_birth, :rsa_number,
          :foreign_id, :sa_tax_number, :email, :phone_no,
          :employer, :occupation, :employment_nature, :job_title,
          :previous_employment, :occupation_jurisdiction
        )
      end
    end
  end
end
