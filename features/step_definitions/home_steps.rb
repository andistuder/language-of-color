When 'I visit the homepage' do
  visit '/'
end

Then 'I can see the navigation' do
  expect(page).to have_css('ul.nav')
end
