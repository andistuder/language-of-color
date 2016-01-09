Feature: Membership

  Background:
    Given an administrator exists

  @wip
  Scenario: Members can register
    When I register as a member
    And my account is approved
    When I log in
    Then I can see my details listed on the members page
    When I edit my details
    Then I can see my details listed on the members page
    And I can log out

  @wip
  Scenario: Members can delete their account
    When I register as a member
    And my account is approved
    When I log in
    Then I can delete my account

  Scenario: Admin adds member
    When the administrator adds me as a member
    And the administrator triggers an activation email to the new member
    Then the member receives an email with instructions on how to set a password
    And the member can activate their account

  Scenario: Member can edit details
    Given an approved member exists
    When I log in
    Then I can edit my details
    And I can log out

  Scenario: Member can cancel membership
    Given an approved member exists
    When I log in
    Then I can cancel my membership

  Scenario: Membership index
    Given the following members exist:
      | first_name | last_name | country_of_residence | link               | approved   |
      | John       | Snow      | UK      | http://john.com    | true       |
      | Konrad     | Tyler     | DE      | http://kondrad.com | false      |
    Then I should only see details of the approved members exluding emails
    When I log in
    Then I should only see details of the approved members including emails
