# Colour Group

## Managing data

Rails admin, a basic content management system is used to manage data.

1. Create a member via webform
2. Run on a rails console: `Member.find_by_email('andi@test.com').update_attribute(:is_admin, true)`
3. Log in at '/admin'

## Sitemap

When changing pages, update `config/site_map.rb` and republish the sitemap:

`rake sitemap:refresh:no_ping`

## Development

Start a local server with connection to the S3 production bucket:

`bin/boot_with_heroku_options`

## Test

Run tests with

`bin/rake`
