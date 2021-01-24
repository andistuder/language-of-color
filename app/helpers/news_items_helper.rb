# frozen_string_literal: true

require 'kramdown'

module NewsItemsHelper
  def markup(text)
    raw(Kramdown::Document.new(text).to_html) if text.present?  # rubocop:disable Rails/OutputSafety
  end
end
