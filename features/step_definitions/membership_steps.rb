When 'I register as a member' do
  @member = build(:member)
  visit '/'
  click_link_or_button 'Register now'

  within('#new_member') do
    fill_in 'Email', with: @member.email
    fill_in 'First name', with: @member.first_name
    fill_in 'Last name', with: @member.last_name
    fill_in 'Link', with: @member.link
    fill_in 'Password', with: @member.password
    fill_in 'Password confirmation', with: @member.password
  end
  click_button 'Sign up'
end

Then 'I can see my details listed on the members page' do
  click_link_or_button 'Members'
  expect(page).to have_content(@member.first_name)
  expect(page).to have_content(@member.last_name)
  expect(page).to have_link(@member.link)
  # expect(page).to have_link("mailto:#{@member.email}")
end

When 'I edit my details' do
  @member.email = 'johnny@example.com'
  @member.first_name = 'Johnny'
  @member.last_name = 'Dow-Lo'
  @member.link = 'http://www.johnny.com'

  click_link_or_button 'Edit my details'
  within('#edit_member') do
    fill_in 'Email', with: @member.email
    fill_in 'First name', with: @member.first_name
    fill_in 'Last name', with: @member.last_name
    fill_in 'Link', with: @member.link
    fill_in 'Current password', with: @member.password
  end
  click_button 'Update'
end

Then 'I can log out' do
  click_link_or_button 'Log out'
  expect(page).to have_content('Signed out successfully')
end

Then 'I can delete my account' do
  click_link_or_button 'Edit my details'
  click_link_or_button 'Cancel my membership'
  expect(page).to have_content('Bye! Your account has been successfully cancelled.'\
                               'We hope to see you again soon.'
                              )
end
