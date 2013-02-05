#-----------------------------------------------------------------------------79
# Publisher steps
# (c) 2012 RedRover
#-------------------------------------------------------------------------------

#
# Given steps
#
Given /^I visit the publisher details page for publisher "([^\"]*)"$/ do |publisher_id|
  visit "#/publishers/#{publisher_id}"
end

#
# When steps
#

#
# Then steps
#
Then /^I should see the publisher "(.*?)" in the "(.*?)" category$/ do |publisher_name, category_name|
  page.should have_css(".#{category_name} .detail_view", :text => publisher_name)
end
