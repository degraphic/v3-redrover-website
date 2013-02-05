Feature: User Profile

  Scenario: As a user, I want to be able to view another user's profile. (basic info)
    Given I visit the user profile page for user "1"
    Then I should see "User profile name" as a user name
    And I should see "User profile bio" as a profile bio description
    # TODO: test user avatar

  Scenario: Follow user
    When I log in
    And I visit the user profile page for user "1"
    Then I should see "#follow_user"
    And I click "follow_user"
    Then I should see "#unfollow_user"

  Scenario: Unfollow user
    When I log in
    And I visit the user profile page for user "1_followed"
    Then I should see "#unfollow_user"
    And I click "unfollow_user"
    Then I should see "#follow_user"

