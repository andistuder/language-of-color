# Colour Group

## Managing data

Rails admin, a basic content management system is used to manage data.

1. Create a member via webform
2. Run on a rails console: `Member.find_by_email('andi@test.com').update_attribute(:is_admin, true)`
3. Log in at '/admin'
