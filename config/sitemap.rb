# frozen_string_literal: true

SitemapGenerator::Sitemap.default_host = 'http://language-of-color.aic-color.org'

SitemapGenerator::Sitemap.create do
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  add about_path
  add members_path, priority: 0.7, changefreq: 'daily'
  add bibliography_path
  add resources_path
  add contact_path
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
