Feature: Sign Up

  Scenario: Sign up with email
    Given I visit the "home" page
    And I click "Sign Up"
    And I click "Connect with Email"
    Then I should see "the user registration form"
    When I enter "Michael" in "first_name" within "the user registration form"
    And I enter "a random email" in "email" within "the user registration form"
    And I enter "Jackson" in "last_name" within "the user registration form"
    And I enter "password" in "password" within "the user registration form"
    And I enter "password" in "confirm password" within "the user registration form"
    And I click the button "Connect Now"
    Then I should see "the user logged in dropdown"
