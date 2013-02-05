Feature: Publisher Details

  Scenario: View Publisher Details
    Given I visit the publisher details page for publisher "1"
    Then I should see text "New York Public Library"
  
  # Note: the follow/unfollow tests should have a further step
  # that goes back to the page and make sure the change stuck;
  # doesn't seem possible with current test structure - JL
  Scenario: Follow publisher
    When I log in
    And I visit the publisher details page for publisher "2"
    And I click "follow_publisher"
    Then I should see "#unfollow_publisher"
  
  @wip
  Scenario: Unfollow publisher
    When I log in
    And I visit the publisher details page for publisher "1"
    Then I should see "#unfollow_publisher"
    And I click "unfollow_publisher"
    Then I should see "#publishers"

  Scenario: if user click some event publisher box it should redirect to the event details for this one
    When I log in
    And I visit the publisher details page for publisher "1"
    And I click the ".detail_view:first" element
    Then I should see text "On the Classic Mickey Mantle"
    And I should see "#event-detail"
