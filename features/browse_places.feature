Feature: Browse Places

  Scenario: categories
    Given I visit the "browse all places" page
    Then I should see 1 place categories

  Scenario: Categories search panel
    Given I visit the "browse all places" page
    And I click the button "categoryTrigger"
    And I click the "#categories li:nth(-n+1)" element
    And I click the button "distanceTrigger"
    And I click the "#distances li:nth(-n+2)" element
    Then I should see text "Parks & Beaches"

  Scenario: find places with search panel with logged user
    Given I visit the "browse all places" page
    And I click the button "categoryTrigger"
    And I click the "#categories li:nth(-n+1)" element
    And I click the button "distanceTrigger"
    And I click the "#distances li:nth(-n+2)" element
    And I enter "Ama" in "locationAutocomplete"
    And I wait the ajax request for 1 seconds
    And I select the first option into the google places list 
    And I click the button "Filter"
    Then I should see 1 place categories
  
  Scenario: find places starred by People I Follow with logged user
    Given I visit the "browse all places" page
    And I click the button "categoryTrigger"
    And I click the "#categories li:nth(-n+1)" element
    And I click the ".by_followers" element
    And I click the button "Filter"
    Then I should see 2 instances of ".place"

  Scenario: find places starred by People I Follow with logged user
    Given I visit the "browse all places" page
    And I click the button "categoryTrigger"
    And I click the "#categories li:nth(-n+1)" element
    And I click the ".most_starred" element
    And I click the button "Filter"
    Then I should see 3 instances of ".place"

  Scenario: empty state witn no panel results
    Given I visit the "browse all places" page
    And I click the button "distanceTrigger"
    And I click the "#distances li:nth(n+1)" element
    And I enter "NO PLACE" in "locationAutocomplete"
    And I wait the ajax request for 1 seconds
    And I select the first option into the google places list 
    And I click the button "Filter"
    Then I should see text "place not found!"
    Then I should see text "Try expanding your search."

  Scenario: Default location filter
    Given I visit the "browse all places" page
    Then I should see text "5 MI" in "#distanceTrigger"

  Scenario: 10+ miles on location filter
    Given I visit the "browse all places" page
    And I click the button "distanceTrigger"
    And I click the "#distances li:nth(n+6)" element
    Then I should see text "10+ MI" in "#distanceTrigger"
