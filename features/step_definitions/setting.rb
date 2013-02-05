Then /^I should be redirect to "(.*?)"$/ do |redirect_page|
  uri = URI.parse(current_url)
  "##{uri.fragment}".should == page_url(redirect_page)
end


Given /^I go to Setting User Option$/ do
   step "I click the user options"
   step "I click the user options" 
   step 'I click "settings_option"'
end