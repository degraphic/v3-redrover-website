Feature: Sign In

  Scenario: Sign in with RR credentials
    Given I visit the "home" page
    And I click "Log In"
    Then I should see "the user Login form"
    When I enter "pedrazaj_24@hotmail.com" in "login_email" within "the user Login form"
    And I enter "password" in "login_password" within "the user Login form"
    And I click the button "Log In"
    Then I should see "the user logged in dropdown"
    Then I should see "Flash Message" of type "Success"