Feature: Settings Features
  Scenario: Redirect to root if not logged user
    Given I visit the "settings" page
    Then  I should be redirect to "featured events"

  Scenario: View Page Settings 
    When I log in
    And  I go to Setting User Option
    Then I should see text "Settings" in "h1"
    And I should see text "Profile" in "h2"
    And I should have value "Jose David" in field "firstName"
    And I should have value "Pedraza" in field "lastName"
    And I should have value "pedrazaj_24@hotmail.com" in field "userEmail"
    And I should have value "" in field "userZipcode"

  Scenario: Modify username, zipcode, gender and email
    Given I log in
    And  I go to Setting User Option
    And I enter "charly.palencia@gmail.com" in "userEmail" 
    And I enter "Charly" in "firstName"
    And I enter "32145" in "userZipcode"
    And I click the element "#userGender"
    When I click the button "Save Settings"
    Then I should see "Flash Message" of type "Success"

  Scenario: Show error with wrong data in password form
    Given I log in
    And  I go to Setting User Option
    And I click "Change Password"
    And I click the button "Update"
    Then I should see "Flash Message" of type "Error"

    And I enter "admin" in "current_password"
    And I click the button "Update"
    Then I should see "Flash Message" of type "Error"

    And I enter "123" in "new_password"
    And I enter "1234" in "confirm_new_password"
    And I click the button "Update"
    Then I should see "Flash Message" of type "Error"

    And I enter "123" in "confirm_new_password"
    And I click the button "Update"
    Then I should see "Flash Message" of type "Error"
  
  Scenario: Update Password
    Given I log in
    And  I go to Setting User Option
    And I click "Change Password"
    And I enter "admin123" in "current_password"
    And I enter "123456" in "new_password"
    And I enter "123456" in "confirm_new_password"
    And I click the button "Update"
    Then I should see "Flash Message" of type "Success"
    And I should have value "" in field "current_password"
    And I should have value "" in field "new_password"
    And I should have value "" in field "confirm_new_password"

  Scenario: Update Privacy Settings
    Given I log in
    And  I go to Setting User Option
    And I click "Privacy"
    And I select "Approved Followers" from the "following_privacy_select" Select Box
    And I select "Private" from the "followers_privacy_select" Select Box
    And I select "Public" from the "saved_events_select" Select Box
    And I select "Private" from the "saved_places_select" Select Box
    And I select "Approved Followers" from the "feeds_privacy_select" Select Box
    And I click the button "Done"
    Then I should see "Flash Message" of type "Success"