module Profilable
  extend ActiveSupport::Concern

  included do
    has_one :user, as: :profile, foreign_type: :user_type, dependent: :nullify
    has_one :person, as: :profile, foreign_type: :user_type, dependent: :destroy

    accepts_nested_attributes_for :person
    validates :person, presence: true
  end
end
