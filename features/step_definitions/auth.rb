#-----------------------------------------------------------------------------79
# Event steps
# (c) 2012 RedRover
#-------------------------------------------------------------------------------

#
# Given steps
#

#
# When steps
#
When /^I log in$/ do
  step 'I visit the "home" page'
  step 'I click "Log In"'
  step 'I enter "pedrazaj_24@hotmail.com" in "login_email" within "the user Login form"'
  step 'I enter "password" in "login_password" within "the user Login form"'
  step 'I click the button "Log In"'
  
  # this step has to wait b/c after the user authenticates,
  # he's redirected to 'my redrover', which will happen *after*
  # the next step (so if that step goes to a page, you have a problem)
  sleep 2
end

#
# Then steps
#