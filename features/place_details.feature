Feature: Place Details

  Scenario: i can not see the follow but like public user
    Given I visit the place details page for place "1"
    Then I should not see text Follow

  Scenario: i can not see the save but like public user
    Given I visit the place details page for place "1"
    Then I should not see text start option

  Scenario: Logged In User is saving a place
    Given I visit the "home" page
    When I log in
    Given I visit the place details page for place "1"
    Then I should see 1 instances of ".icomoon-star"

    Given I visit the place details page for place "1"
    And I click the "#start" element within ".connect"
    Then I should see 1 instances of ".icomoon-star.active"
    
  Scenario: List Place comment when user is logged
    When I log in
    Then  I visit the place details page for place "1"
    Then I should see the comments panel
    And I should see 2 place comments

  Scenario: Follow place for logged user
    When I log in
    And  I visit the place details page for place "1"
    And I click the button "Follow"
    Then I should see text "Following"
  
  Scenario: show following state for logged user
    When I log in
    And  I visit the place details page for place "2"
    Then I should see text "Following"

  Scenario: Create a comment when a user is logged
    When I log in
    Given  I visit the place details page for place "1"
    And I wait until all Ajax requests are complete
    And I enter "GOOD CHOICE" in "commentContent"
    And I click the element "#addPlaceComment"
    And I wait until all Ajax requests are complete
    Then I should see 3 place comments

  Scenario: As not logged user i could not see the place comments 
    Given  I visit the place details page for place "1"
    Then I should not see any "comments"

  Scenario: As a not logged user i could see the publisher for this place and their events
    Given  I visit the place details page for place "1"
    And I wait until all Ajax requests are complete
    Then I should see text "Queens Botanical Garden"
    Then I should see text "Fragile Beauty: Jamaica Bay Landscapes"

    


