# How-to add new email template

This guide shows you how to add new email template in the rails application and Mailchimp panel.
We have some template variables mappings done to be sure that templates defined in the Mailchimp are compatible with our application.

## Add Email template in Mailchimp

1. Create template in [Mailchimp admin panel](https://admin.mailchimp.com/templates/)
2. Export the created template to Mandrill using "Send to Mandrill" option.

Now it should be ready to use!

In the Mailchimp templates we use variables like `*|first_name|*` to be replaced by us. You can find more details about it [here](https://mailchimp.com/developer/transactional/docs/templates-dynamic-content/#mailchimp-merge-language)

## Add Email template in rails application

1. Create a new class somewhere in `contexts/notifications/emails/temapltes` which inherits from `Notifications::Emails::Templates::Base` - this class will map defined variables to the structure of Mailchimp template
2. Implement required methods:
    - `required_fields` - which is used for validation purposes to be sure that all required fields form Mailchimp template are given
    - `name` - the name of Mailchimp template
    - `subject` - the email subject
    - `global_merge_vars` - which should contains array of pairs name/content (key/value) we want to replace/override in Mailchimp template.

   Example templates class you can find here: [email_configuration](../../app/contexts/notifications/emails/templates/email_confirmation.rb)
3. Create a new use case to populate template with data, validate it and send email

   Example use case you can find here: [send_confirmation_email](../../app/contexts/notifications/emails/use_cases/send_confirmation_email.rb)

More details about transactional emails and how we send templates is [here](https://mailchimp.com/developer/transactional/api/messages/send-using-message-template/)

## List of all supported email templates in our application
[Here](../references/email_templates.md) you can find the document about supported email templates in our application.
