# frozen_string_literal: true

class AdminUser < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :rememberable, :validatable
end
