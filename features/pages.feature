Feature: Static Pages

  Scenario: Home page loads
    When I visit the homepage
    Then I can see the navigation
    And I can see the page heading "Language of Color a study group of the AIC"
    And I can see the page subheading "News"

  Scenario: About page loads
    When I visit "/about"
    Then I can see the page heading "About the Language of Color AIC Study Group"
    And I can see the page subheading "Scope"
    And I can see the page subheading "Chairman: Dimitris Mylonas"
    And I can see the page subheading "Co-Chairwoman: Prof. Galina Paramei"

  Scenario: Contact page loads
    When I visit "/bibliography"
    Then I can see the page heading "Bibliography"

  Scenario: Contact page loads
    When I visit "/contact"
    Then I can see the page heading "Contact"

  Scenario: Disclaimer page loads
    When I visit "/disclaimer"
    Then I can see the page subheading "Disclaimer"
    And I can see the page subheading "Impressum"

  Scenario: Members page loads
    When I visit "/members"
    Then I can see the page heading "Members"

  Scenario: Resources page loads
    When I visit "/resources"
    Then I can see the page heading "Resources"
