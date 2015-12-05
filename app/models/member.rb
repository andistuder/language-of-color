require 'csv'

class Member < ActiveRecord::Base
  after_create :send_admin_mail

  default_scope { order('first_name') }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  PUBLIC_ATTRS = %w(first_name  last_name title country_of_residence  job_title organisation  link  email)

  def self.send_reset_password_instructions(attributes = {})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t('devise.failure.member.not_approved')
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << PUBLIC_ATTRS
      all.find_each do |product|
        csv << product.attributes.values_at(*PUBLIC_ATTRS)
      end
    end
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def send_admin_mail
    MemberMailer.new_member_waiting_for_approval(self).deliver
  end
end
