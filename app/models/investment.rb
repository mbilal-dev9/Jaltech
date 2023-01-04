# frozen_string_literal: true

class Investment < ApplicationRecord
  belongs_to :product
  belongs_to :profile, polymorphic: true, foreign_type: :profile_type

  monetize :amount_cents

  validates :profile_type, presence: true, inclusion: {in: %w[Investor Company],
                                                       message: I18n.t("errors.messages.invalid_profile_type")}
end
