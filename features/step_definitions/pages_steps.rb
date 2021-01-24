# frozen_string_literal: true

When 'I visit the homepage' do
  visit '/'
end

When 'I visit {string}' do |string|
  visit string
end

Then 'I can see the navigation' do
  navigation_items = page.find_all('ul.nav li')
  expect(navigation_items.length).to eq(6)
  expect(navigation_items[0]).to have_xpath('.//a[@href="/about"]', text: 'About')
  expect(navigation_items[1]).to have_xpath('.//a[@href="/members"]', text: 'Members')
  expect(navigation_items[2]).to have_xpath('.//a[@href="/bibliography"]', text: 'Bibliography')
  expect(navigation_items[3]).to have_xpath('.//a[@href="/resources"]', text: 'Resources')
  expect(navigation_items[4]).to have_xpath('.//a[@href="/contact"]', text: 'Contact')
  expect(navigation_items[5]).to have_xpath('.//a[@href="/members/sign_in"]', text: 'Log in')
end

Then 'I can see the page heading {string}' do |string|
  expect(find('h1')).to have_content(string)
end

Then 'I can see the page subheading {string}' do |string|
  expect(page).to have_xpath('.//h2', text: string)
end
