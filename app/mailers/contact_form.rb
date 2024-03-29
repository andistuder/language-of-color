# frozen_string_literal: true

class ContactForm < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w.%+\-]+)@([\w\-]+\.)+(\w{2,})\z/i

  attribute :message,   validate: true
  attribute :subscribe_to_mailing_list
  attribute :nickname, captcha: true

  def headers
    {
      subject: 'Website Contact Form',
      to: 'sg-lc@aic-color.org',
      from: %("#{name}" <#{email}>)
    }
  end
end
