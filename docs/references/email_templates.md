# Email templates used in our application
This project uses the Mailchimp Transactional API to send emails and Mailchimp templates to define the look of the email message.

Notice that Mailchimp Transaction API is not available for the Free plan, please.

To communicate with Mailchimp API we use `MailchimpTransactional` gem. The communication requires an [API key](https://mailchimp.com/developer/transactional/guides/quick-start/#generate-your-api-key) which is kept by `MAILCHIMP_API_KEY` environment variable.

You can find [here](../guides/email_templates.md) how to add a new email template to our application.


## Templates
There is a list of used Mailchimp email templates in our application.

### Email confirmation
**Template name:** `Jaltech_user_email_confirmation`

**Required variables:**
- `first_name` - client's first name
- `user_type` - user's type (investor, company, advisor)
- `confirmation_url` - url to confirm an email address


**Template name:** `Jaltech_user_password_reset`

**Required variables:**
- `reset_password_url` - url to reset password form
