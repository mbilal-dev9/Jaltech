# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :secure_validatable
  include DeviseTokenAuth::Concerns::User

  PROFILE_TYPES = %w[Investor Advisor Company]

  belongs_to :profile, polymorphic: true, foreign_type: :user_type, dependent: :destroy
  accepts_nested_attributes_for :profile

  def build_profile(params)
    raise "Unknown user_type: #{user_type}" unless PROFILE_TYPES.include?(user_type)
    self.profile = user_type.constantize.new(params)
  end
end
