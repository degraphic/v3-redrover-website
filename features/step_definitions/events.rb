#-----------------------------------------------------------------------------79
# Event steps
# (c) 2012 RedRover
#-------------------------------------------------------------------------------

#
# Given steps
#
Given /^I visit the "([^\"]*)" page$/ do |page|
  visit page_url(page)
end

Given /^I visit the "home page under registered social domain"$/ do
  visit "/"
end

Given /^I visit the event details page for event "([^\"]*)"$/ do |event_id|
  visit "#/events/#{event_id}"
end

Given /^I click the button "(.*?)" in the top search panel$/ do |button_name|
	click_button button_name
end

Given /^I click the input "(.*?)"$/ do |input_id|
	find_field( input_id ).click
end

Given /^I click the day "(.*?)" into the datepicker$/ do |content_link|
	click_link content_link
end


Given /^I click the link "(.*?)"$/ do |content_link|
  click_link content_link
end

Given /^I select the first option into the google places list$/ do
 find(".pac-container .pac-item:first").click
end



#
# When steps
#

#
# Then steps
#
Then /^I should see (\d+) promoted event$/ do |count|
  page.should have_css('.event.large', :count => count.to_i)
end

Then /^I should see (\d+) featured events$/ do |count|
  page.should have_css('.event.small', :count => count.to_i)
end

Then /^I should see (\d+) events$/ do |count|
  page.should have_css('.detail_view', :count => count.to_i)
end

Then /^I should see (\d+) search results$/ do |count|
  page.should have_css('.results-wrap .ember-view li.result', :count => count.to_i)
end

Then /^I should see (\d+) search results in the autocomplete$/ do |count|
  page.should have_css('.search_results .ember-view li.result', :count => count.to_i)
end

Then /^I should see (\d+) event categories$/ do |count|
  page.should have_css('.category', :count => count.to_i)
end

Then /^the event title should be "(.*?)"$/ do |title|
	page.should have_content( title )
end

Then /^I should see before and after event "(.*?)"$/ do |name|
  page.should have_css('.detail_view .title', :text => name)
end

Then /^I should see (\d+) event comments$/ do |count|
  page.should have_css('.row_comment', count: count)
end
