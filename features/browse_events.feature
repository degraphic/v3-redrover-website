Feature: Browse Events

  Scenario: Browse all Events
    Given I visit the "browse all events" page
    And I should see 1 events

  Scenario: Browse all Events day filters
  	As a user, I want to filter my browse all events by date scopes

  	Given I visit the "browse all events" page
  	And I click the button "Today" in the top search panel
    Then I should see 1 events
    And the event title should be "Today Event"

  	Given I visit the "browse all events" page
  	And I click the button "Tomorrow" in the top search panel
    Then I should see 1 events
    And the event title should be "Tomorrow Event"  

  	Given I visit the "browse all events" page
  	And I click the button "Weekend" in the top search panel
    Then I should see 2 events
    And the event title should be "Today Event"
    And the event title should be "Tomorrow Event"

    Given I visit the "browse all events" page
    And I click the button "Calendar" in the top search panel
    And I click the day "23" into the datepicker 
    Then I should see 1 events
    And the event title should be "Today Event"
      
  Scenario: Browse all Events by age filters
    Given I visit the "browse all events" page
    And I click the link Show Additional Filters
    And I click the button "Baby and Toddlers" in the top search panel
    Then I should see 2 events

    Given I visit the "browse all events" page
    And I click the link Show Additional Filters
    And I click the button "Kids And Teens" in the top search panel
    Then I should see 1 events

    Given I visit the "browse all events" page
    And I click the link Show Additional Filters
    And I click the button "Grown Ups Only" in the top search panel
    Then I should see 3 events

  Scenario: Browse all Events by age and date filters 
    Given I visit the "browse all events" page
    And I click the link Show Additional Filters
    And I click the button "Baby and Toddlers" in the top search panel
    And I click the button "Tomorrow" in the top search panel
    Then I should see 4 events
    And I click the button "Baby and Toddlers" in the top search panel
    Then I should see 1 events

  Scenario: Browse all Events  filter by distance 
    Given I visit the "browse all events" page
    And I click the button "distanceTrigger" in the top search panel
    And I click the link "0.5 mile"
    Then I should see 1 events

  Scenario: Browse all Events filter by location
    Given I visit the "browse all events" page
    And I click the link Show Additional Filters
    And I enter "Ama" in "locationAutocomplete"
    And I wait the ajax request for 1 seconds
    And I select the first option into the google places list 
    And I click the button "Filter"
    Then I should see 1 events

  Scenario: Browse all Events filter by followers
    Given I visit the "browse all events" page
    And I click the link Show Additional Filters
    And I click the checkbox "events_by_followers"
    Then I should see 1 events
    And the event title should be "Starred by my followers"

  Scenario: Browse all Events filter by most starred
    Given I visit the "browse all events" page
    And I click the link Show Additional Filters
    And I click the checkbox "events_by_starred"
    Then I should see 1 events
    And the event title should be "Starred Most"