# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :twitter

  protected

  def configure_permitted_parameters
    additional_fields = %i[
      first_name
      last_name
      title
      country_of_residence
      job_title
      organisation
      link
    ]
    devise_parameter_sanitizer.for(:sign_up).push(additional_fields)
    devise_parameter_sanitizer.for(:account_update).push(additional_fields)
  end

  def twitter
    @tweets = tweets
  rescue StandardError => e
    logger.error("Error fetching tweets: #{e}")
  end

  def tweets
    Rails.cache.fetch('tweets', expires_in: 10.minutes) do
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
      end
      client.user_timeline(TWITTER_NAME, count: 3) if ENV['TWITTER_ACCESS_TOKEN'].present?
    end
  end

  def authorize
    render plain: '403 Forbidden', status: :forbidden unless current_member.try(:is_admin?)
  end
end
