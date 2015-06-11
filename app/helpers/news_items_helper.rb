require 'kramdown'

module NewsItemsHelper
  def markup(text)
    raw(Kramdown::Document.new(text).to_html) if text.present?
  end
end
