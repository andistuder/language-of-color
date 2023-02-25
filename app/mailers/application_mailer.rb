# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'sg-lc@aic-color.org'
  layout 'mailer'
end
