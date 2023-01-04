# frozen_string_literal: true

class SendTemplateEmailJob
  include Sidekiq::Job

  def perform(email, template_vars)
    adapter = Emails::MailchimpClient.new
    template_hash = JSON.parse(template_vars).with_indifferent_access

    adapter.send_email(template_hash[:name], template_hash[:content], message(email, template_hash))
  end

  private

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
