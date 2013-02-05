#
# Given steps
#
Given /^I visit the user profile page for user "([^\"]*)"$/ do |user_id|
  visit "#/users/#{user_id}"
end

#
# Then steps
#
Then /^I should see "([^\"]*)" as a user name$/ do |name|
  page.should have_content( name )
end

#
# And Steps
#
And /^I should see "([^\"]*)" as a profile bio description$/ do |bio|
  page.should have_content( bio )
end