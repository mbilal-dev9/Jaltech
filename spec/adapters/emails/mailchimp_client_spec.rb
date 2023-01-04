# frozen_string_literal: true

require "rails_helper"

RSpec.describe Emails::MailchimpClient do
  subject(:mailchimp_adapter) { described_class.new }

  specify "#send_email" do
    expect(mailchimp_adapter.method(:send_email).arity).to eq(3)
  end
end
