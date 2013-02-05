#-----------------------------------------------------------------------------79
# Event steps
# (c) 2012 RedRover
#-------------------------------------------------------------------------------

#
# Given steps
#
Given /^I visit the place details page for place "([^\"]*)"$/ do |place_id|
  visit "#/places/#{place_id}"
end

#
# When steps
#

#
# Then steps
#
Then /^I should see before and after place "(.*?)"$/ do |name|
  page.should have_css('.detail_view .name', :text => name)
end


Then /^I should see the comments panel$/ do
  page.should have_css('#comments')
end	

Then /^I should see (\d+) place comments$/ do |count|
  page.should have_css('.row_comment', count: count)
end

Then /^I should see (\d+) place categories$/ do |count|
  page.should have_css('.place-category', count: count)
end

Then /^I should see (\d+) place slide$/ do |count|
  page.should have_css('.place-tile.span5.slide', count: count)
end

Then /^I write the comments "(.*?)"$/ do |arg1|
    fill_in('descripctionComment', :with => 'GOOD CHOICE')
end

Then /^I should not see any "(.*?)"$/ do |element_id|
  page.should_not have_css("##{element_id}")
end



