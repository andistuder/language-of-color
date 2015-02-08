Feature: Static Pages

  Scenario: Home page loads
    When I visit the homepage
    Then I can see the navigation

  Scenario: About page loads
    When I visit "/about"
    Then I can see the page heading "About Language of Colour"
