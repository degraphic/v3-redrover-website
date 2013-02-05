#-----------------------------------------------------------------------------79
# Selector transforms, to make steps more human friendly and reduce
# duplication.
# (c) 2012 RedRover
#-------------------------------------------------------------------------------
def find_page_element(*args)
  element = page.find(*args)
end

def should_see?(text)
  text.blank? or text.strip != 'not'
end

def require_active_element
  assert @element, "You must set the active element first"
end

def to_css(text)
  case text
  when 'the user registration form' then '.signup-form'
  when 'the user Login form' then '.LP-login-form'
  when 'the user logged in dropdown' then '#user-menu'
  when 'the Facebook Login button' then 'btn-fb'
  when 'the Twitter Login button' then 'btn-tw'
  when 'the submit button' then '#submit'
  when 'my full name' then '#my_full_name'
  when 'my profile picture' then '#my_profile_picture'
  when 'the save event button' then 'save'
  when 'the event info' then '.event .info'
  when 'Saved Event' then '.my-event'
  when 'Saved Place' then '.my-place'
  when 'Flash Message' then '.alert'
  when 'Success' then '.alert-success'
  when 'Error' then '.alert-error'
  when 'Default' then '.alert-default'
  when 'Info' then '.alert-info'
  else
    text
  end
end

def to_field(text)
  case text
  when 'confirm password' then 'password_confirmation'
  else
    text
  end
end

