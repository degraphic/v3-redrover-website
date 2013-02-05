Feature: My Redrover

  Scenario: Visit
    When I log in
    And I click "nav_my_redrover"
    Then I should see text "Jose David Pedraza" in "my full name"
    And the image "my profile picture" should have URL "http://s3.amazonaws.com/rr-staging/production/users/medium/4/profile_picture.png?1352577424"
    Then I should see 2 instances of "Saved Event"
    Then I should see 1 instances of "Saved Place"

   Scenario: Edit Profile
   	When I log in
    And I click "nav_my_redrover"
    And I click "edit_profile"
    Then I should have value "Jose David" in field "edit_first_name"
    Then I should have value "Pedraza" in field "edit_last_name"
    Then I should have value "" in field "edit_bio"
    When I enter "This is my Bio!" in "edit_bio"
    And I click the button "Save"
    Then I should see text "This is my Bio!"
    Then I wait the ajax request for 3 seconds
    Then I should see "Flash Message" of type "Success"