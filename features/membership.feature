Feature: Membership

  Background:
    Given an administrator exists

  Scenario: Members can register
    When I register as a member
    And my account is approved
    When I log in
    Then I can see my details listed on the members page
    When I edit my details
    Then I can see my details listed on the members page
    And I can log out

  Scenario: Members can delete their account
    When I register as a member
    And my account is approved
    When I log in
    Then I can delete my account
