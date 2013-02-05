 Feature: Event Details

  Scenario: As not logged user i could not see the event comments
    Given I visit the event details page for event "1"
    Then I should not see any "comments"

  Scenario: Before & After Events
    Given I visit the event details page for event "1"
    Then I should see before and after event "Mickey Mousescapade"
    And I should see before and after place "McDonald's"

  Scenario: View Event Details
    When I log in
    Given I visit the event details page for event "1"
    Then I should see text "Melrose Library"
    And I should see text "Room rental"

  Scenario: List Event comment when a user is logged
    When I log in
    And I wait until all Ajax requests are complete
    Given I visit the event details page for event "1"
    Then I should see the comments panel
    And I should see 2 event comments

  Scenario: Create a new comments When  a user is logged
    When I log in
    And I wait until all Ajax requests are complete
    Given I visit the event details page for event "1"
    And I enter "GOOD CHOICE" in "commentContent"
    And I click the element "#addCommentButton"
    And I wait until all Ajax requests are complete
    Then I should see 3 event comments

  Scenario: Category label 
    When I visit the event details page for event "1"
    Then I should see text "Category"
    Then I should see text "Games"
  
  Scenario: Purchase Ticket
    When I visit the event details page for event "1"
    Then I should see text "Purchase Tickets"

  Scenario: Save RedRover without user logged
    When I visit the event details page for event "1"
    Then I should not see text "Save On RedRover"
    Then I should not see text start option

  Scenario: Save RedRover with a user logged
    When I log in
    And I visit the event details page for event "1"
    And I click the element ".icomoon-star"
    Then I should see ".icomoon-star"
    Then I should see text "Save On RedRover"
    
  Scenario: show state unsave RedRover with a user logged
    When I log in
    And I visit the event details page for event "1"
    And I click the element ".icomoon-star"
    And I click the element "#save-event"
    Then I should see text "Unsave Event"

  Scenario: Calendar Options 
    When I log in
    And I visit the event details page for event "1"
    And I click the element ".icomoon-star"
    And I click the element "#add-to-calendar"
    And I click the element ".calendar li:first"

