# frozen_string_literal: true

module Admin
  class PeopleController < Admin::ApplicationController
    before_action :authenticate_admin!
  end
end
