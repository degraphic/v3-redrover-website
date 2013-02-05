#-----------------------------------------------------------------------------79
# Web steps
# (c) 2012 RedRover
#-------------------------------------------------------------------------------

#
# Given steps
#

#
# When steps
#

When /^I click the button "(.*?)"$/ do |button_name|
  click_button button_name
end

When /^I click "([^\"]*)"( within "([^\"]*)")?$/ do |selector, has_within, within|
  if has_within
    within(to_css(within)) do
      click_on(to_css(selector))
    end
  else
    click_on(to_css(selector))
  end
end

# Needed because click_on needs a link or button
When /^I click the "([^\"]*)" element( within "([^\"]*)")?$/ do |selector, has_within, within|
  if has_within
    within(to_css(within)) do
      find(to_css(selector)).click
    end
  else
    find(to_css(selector)).click
  end
end

Given /^I click the link Show Additional Filters$/ do ||
 find("#show_filter").click
end

When /^I click the user options$/ do
  find("#user_options").click
end

Then /^I click the start option$/ do
  find(".connect .start").click
end

 


Given /^I click the element "(.*?)"$/ do |selector|
 find(selector).click
end

Given /^I click the checkbox "(.*?)"$/ do |input_id|
  find_field( input_id ).click
end

And /^I select "(.*?)" from the "(.*?)" Select Box$/ do |option, select_box|
  select(option, :from => select_box)
end

When /^I enter "([^\"]*)" in "([^\"]*)"( within "([^\"]*)")?$/ do |value, field, has_within, within|
  if value == 'a random email'
    value = "#{SecureRandom.urlsafe_base64}@redroverapp.com"
  end
  
  if has_within
    within(to_css(within)) do
      fill_in to_field(field), :with => value
    end
  else
    fill_in to_field(field), :with => value
  end
end

When /^I grant Facebook access$/ do
  begin
    main, popup = page.driver.browser.window_handles
    within_window(popup) do
      fill_in("Email or Phone:", :with => "ocyafvw_fergiebergsonsenescusteinskywitzman_1355174589@tfbnw.net")
      fill_in("Password:", :with => "facebookuser")
      click_on("Log In")
    end
  rescue
  end
end

When /^I grant Twitter access$/ do
  main, popup = page.driver.browser.window_handles
  within_window(popup) do
    fill_in("username_or_email", :with => "jose@redroverapp.com")
    fill_in("password", :with => "twitteruser")
    click_on("Connect")
  end
end

When /^I wait for twitter popup$/ do
  flag=false
  wait_until(4) do
    window_handles = page.driver.browser.window_handles
    within_window(window_handles.last) do
      flag = page.current_url.include?("twitter")
    end
    flag
  end
end

When /^I hover on "([^\"]*)"$/ do |selector|
  page.driver.browser.execute_script %Q{
    $("#{to_css(selector)}").trigger("mouseenter");
  }
end

When /^I press enter in "([^\"]*)"$/ do |selector|
  page.find_field(to_css(selector)).native.send_key(:enter)
end

#
# Then steps
#
Then /^I should( not)? see "([^\"]*)"$/ do |not_flag, selector|
  wait_until do
    if should_see? not_flag
      page.find(to_css(selector)).should be_visible
    else
      page.find(to_css(selector)).should_not be_visible
    end
  end
end

Then /^I should not see text start option$/ do
  page.has_no_css?(".icomoon-star").should be_true 
end

Then /^I should not see text Follow$/ do
  page.has_content?("Follow").should_not be_true 
end

Then /^I should( not)?( wait to)? see text "([^\"]*)"$/ do |not_flag, wait_flag, text|
  if !!wait_flag
    wait_until do
      page.has_content?(text) == should_see?(not_flag)
    end
  else
    page.has_content?(text) == should_see?(not_flag)
  end
end


Then /^I should see text "([^\"]*)" in "([^\"]*)"$/ do |text, selector|
  page.find(to_css(selector)).text.should == text
end

Then /^page show "([^\"]*)" in "([^\"]*)"$/ do |text, selector|
  page.find(to_css(selector)).should have_content( text )
end


Then /^I should have value "([^\"]*)" in field "([^\"]*)"$/ do |text, selector|
  page.find_field(selector).value.should == text
end

Then /^I wait the ajax request for (\d+) seconds$/ do |second|
 sleep second.to_i
end

Then /^the image "([^\"]*)" should have URL "([^\"]*)"$/ do |image, url|
  page.find(to_css(image))['src'].include?(url).should be_true
end

Then /^I should see (\d+) instances of "(.*?)"$/ do |count, selector|
  page.should have_css(to_css(selector), count: count)
end

Then /^I should see "([^\"]*)" of type "([^\"]*)"$/ do |selector, additional_selector|
  page.should have_css(to_css(selector) + to_css(additional_selector))
end

When /^I wait until all Ajax requests are complete$/ do
  wait_until do
    page.evaluate_script('$.active') == 0
  end
end