# frozen_string_literal: true

class MemberMailer < ApplicationMailer
  def new_member_waiting_for_approval(member)
    @member = member
    mail(to: ENV.fetch('NEW_MEMBER_APPROVER', 'dmilonas@gmail.com'), subject: 'New member awaiting approval')
  end
end
