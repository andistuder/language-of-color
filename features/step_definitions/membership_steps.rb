Given 'an administrator exists' do
  @admin = create(:admin)
end

Given 'an approved member exists' do
  @member = create(:approved_member)
end

Given 'the following members exist:' do |table|
  @approved_members = []
  @unapproved_members = []
  table.hashes.each do |hash|
    new_member = create(:member, hash)

    new_member.approved? ? @approved_members << new_member : @unapproved_members << new_member
  end
end

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

When 'my account is approved' do
  log_in(@admin)
  visit '/members'
  click_link_or_button 'Approve!'
  # expect to see?
  click_link_or_button 'Log out'
end

When 'I log in' do
  @member ||= @approved_members.first
  log_in(@member)
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
  expect(page).not_to have_text('Edit my details')
end

Then 'I can delete my account' do
  click_link_or_button 'Edit my details'
  click_link_or_button 'Cancel my membership'
  expect(page).to have_content('Bye! Your account has been successfully cancelled. '\
                               'We hope to see you again soon.'
                              )
end

When 'the administrator adds me as a member' do
  @member = build(:member)
  log_in(@admin)
  click_link_or_button 'Admin'

  within '.rails_admin .member_links' do
    click_link_or_button 'Members'
  end

  click_link_or_button 'Add new'
  within '#new_member' do
    fill_in 'First name', with: @member.first_name
    fill_in 'Last name', with: @member.first_name
    fill_in 'Email', with: @member.email

    check 'member_approved'
    fill_in 'Set password', with: @member.password
    click_link_or_button 'Save'
  end
  expect(page).to have_text('Member successfully created')
  click_link_or_button 'Log out'
end

When 'the administrator triggers an activation email to the new member' do
  visit '/'
  click_link_or_button 'Log in'
  click_link_or_button 'Forgot your password?'
  within '#new_member' do
    fill_in 'Email', with: @member.email
    click_link_or_button 'Send me reset password instructions'
  end
  expect(page).to have_text('You will receive an email with instructions on how to reset your password')
end

Then 'the member receives an email with instructions on how to set a password' do
  email = MemberMailer.deliveries.last
  expect(email.body).to have_link('Change my password')
  @reset_password_link = email.body.match('href="(.*)"')[1]
end

Then 'the member can activate their account' do
  uri = URI.parse(@reset_password_link)
  visit "#{uri.path}?#{uri.query}"
  new_password = 'changme1234'
  # byebug
  within '#new_member' do
    fill_in 'New password', with: new_password
    fill_in 'Confirm new password', with: new_password
    click_link_or_button 'Change my password'
  end
  expect(page).to have_text('Your password has been changed successfully. You are now signed in')
  click_link_or_button 'Members'
  within 'table' do
    expect(page).to have_text @member.last_name
    expect(page).to have_text @member.first_name
  end
  click_link_or_button 'Log out'
end

Then(/^I should only see details of the approved members (exluding|including) emails$/) do |match|
  visit '/members'
  @approved_members.each do |member|
    expect(page).to have_text(member.first_name)
    expect(page).to have_text(member.last_name)
    expect(page).to have_text(member.country_of_residence)
    expect(page).to have_link(member.link)
    if match == 'including'
      expect(page).to have_link(member.email)
    else
      expect(page).not_to have_link(member.email)
    end
  end

  @unapproved_members.each do |member|
    expect(page).not_to have_text(member.first_name)
    expect(page).not_to have_text(member.last_name)
    expect(page).not_to have_text(member.country_of_residence)
    expect(page).not_to have_link(member.link)
  end
end

Then 'I can edit my details' do
  click_link_or_button 'Edit my details'
  within '.edit_member' do
    fill_in 'First name', with: 'Kurt'
    fill_in 'Last name', with: 'Meyer'
    fill_in 'Title', with: 'Dr'
    select 'Angola', from: 'Country of residence'
    fill_in 'Job title', with: 'Doctor'
    fill_in 'Organisation', with: 'New company'
    fill_in 'Email', with: 'http://new.link'
    fill_in 'Email', with: "updated.#{@member.email}"
    click_link_or_button 'Save'
  end
  expect(page).to have_text('Member was successfully updated.')
end

Then 'I can cancel my membership' do
  click_link_or_button 'Edit my details'
  click_link_or_button 'Terminate membership'
  expect(page).to have_text('Membership cancelled: your data was successfully destroyed.')
end

def log_in(member)
  visit '/'
  click_link_or_button 'Log in'
  within('#new_member') do
    fill_in 'Email', with: member.email
    fill_in 'Password', with: member.password
    click_link_or_button 'Log in'
  end
end
