Feature: Membership

  Background:
    Given an administrator exists

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
    When I log in
    Then I should only see details of the approved members including emails
