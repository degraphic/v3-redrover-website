Feature: Browse Activity

  Scenario: As a user, I want to see who's doing what
    When I log in
    And I visit the activity page
    Then I should see ".event_commented"

    And I should see ".friendship_accepted"
    And I should see ".friendship_declined"
    And I should see ".place_commented"
    And I should see ".saved_event"
    And I should see ".saved_place"
    And I should see ".friend_request_sent"