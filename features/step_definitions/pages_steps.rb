When 'I visit the homepage' do
  visit '/'
end

When 'I visit "$path"' do |path|
  visit path
end

Then 'I can see the navigation' do
  expect(page).to have_css('ul.nav')
end

Then 'I can see the page heading "$heading"' do |heading|
  expect(find('h1')).to have_content(heading)
end
