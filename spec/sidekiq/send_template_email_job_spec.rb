# frozen_string_literal: true

require "rails_helper"

RSpec.describe SendTemplateEmailJob, type: :job do
  describe ".perform_now" do
    subject(:send_template_email) { described_class.new.perform(email, template_vars) }

    let(:mailchimp_adapter) do
      instance_double(Emails::MailchimpClient)
    end
    let(:email) { "example@example.com" }
    let(:template_vars) do
      {
        from_email: "from@example.com",
        from_name: "Jaltech",
        name: "template_name",
        subject: "email subject",
        content: [{}],
        global_merge_vars: [{name: :first_name, content: "First name to be replaced in the Mailchimp template"}]
      }.to_json
    end

    let(:template_hash) { JSON.parse(template_vars).with_indifferent_access }

    before do
      allow(Emails::MailchimpClient).to receive(:new).and_return(mailchimp_adapter)
      allow(mailchimp_adapter).to receive(:send_email).with(any_args)
    end

    it "calls mailchimp adapter and sends email" do
      send_template_email
      expect(mailchimp_adapter).to have_received(:send_email).with(template_hash[:name], template_hash[:content], message(email, template_hash))
    end

    def message(email, template_hash)
      {
        from_email: template_hash[:from_email],
        from_name: template_hash[:from_name],
        to: [{email: email}],
        subject: template_hash[:subject],
        global_merge_vars: template_hash[:global_merge_vars]
      }.with_indifferent_access
    end
  end
end
