Feature: Browse Input on header

  Scenario: I wrote my text and press enter
    Given I visit the "home" page
    When I enter "victor theater" in "search_input" within ".navbar-search"
    And I press enter in "search_input"
    And I wait the ajax request for 5 seconds
    Then I should see 5 search results

  Scenario: I wrote a term in the autocomplete
    Given I visit the "home" page
    When I enter "victor theater" in "search_input" within ".navbar-search"
    And I wait the ajax request for 5 seconds
    Then I should see 5 search results in the autocomplete