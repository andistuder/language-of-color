Feature: Membership

  Scenario: Members can register
    When I registers as a member
    Then I can see my details listed on the members page
    When I edit my details
    Then I can see my details listed on the members page
    And I can log out
