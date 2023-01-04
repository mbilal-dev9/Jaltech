class SendResetPasswordEmail
  def initialize(token:, email:)
    @token = token
    @email = email
  end

  def self.call(**args)
    new(**args).call
  end

  def call
    populate_template
    validate_template
    SendTemplateEmailJob.perform_async(@email, template.to_json)
  end

  private

  attr_reader :email, :token

  def populate_template
    template.reset_password_url = reset_password_url
  end

  def validate_template
    raise EmailTemplateNotValid.new("Please define all required fields in template: #{template.required_fields}") unless template.valid?
  end

  def template
    @template ||= Notifications::Emails::Templates::PasswordReset.new
  end

  def reset_password_url
    "#{DeviseTokenAuth.default_password_reset_url}?token=#{token}&email=#{CGI.escape(email)}"
  end
end
