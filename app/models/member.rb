require 'csv'

class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope { order('first_name') }

  PUBLIC_ATTRIBUTES = %w{first_name  last_name title country_of_residence  job_title organisation  link  email}

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << PUBLIC_ATTRIBUTES
      all.each do |product|
        csv << product.attributes.values_at(*PUBLIC_ATTRIBUTES)
      end
    end
  end
end
