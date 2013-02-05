@wip
Feature: Share Event via Email
  Background:
    Given I am logged in

  Scenario: Send email to single recipient
    Given I visit the event details page for event "1"
    When I click "Share"
    Then I should see the share by email entry form
    When I enter "test@redroverapp.com" in the email field
    And I click "Share"
    Then I should see "Your email has been sent"
