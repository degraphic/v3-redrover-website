Feature: Twitter Connect
  Scenario: through the login dropdown
    Given I visit the "home page under registered social domain"
    And I click "Log In"
    And I click "the Twitter Login button" within "the user Login form"
    And I wait for twitter popup
    And I grant Twitter access
    Then I should see "the user logged in dropdown"
    Then I should see "Flash Message" of type "Success"