Feature: Featured Events Page

  Scenario: View Featured Events
    Given I visit the "featured events" page
    Then I should see 1 promoted event
    And I should see 4 featured events
 
  Scenario: Logged In User is saving an event
    Given I visit the "home" page
    When I log in
    Given I visit the "featured events" page
    And I hover on "the event info"
    And I click "the save event button" within ".event"
    Then I should see text "Unsave"

  Scenario: Remove Login box when user click anywhere
   Given I visit the "home" page
   And I click the element ".login"
   Then I should see "#login_email"
   Then I should see text "Email"
   And I click the element "body"
   Then I should not see text "You are now logged in!"
   Then I should not see text "Email"

