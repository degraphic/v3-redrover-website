Feature: Browse Publishers

  Scenario: View Publishers
    Given I visit the "browse publishers" page
    Then I should see the publisher "The Jewish Museum" in the "Museum" category
    And I should see the publisher "Jazz at Lincoln Center" in the "Literary" category
