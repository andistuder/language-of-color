# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'language-of-color@aic-color.org'
  layout 'mailer'
end
