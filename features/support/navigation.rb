# --------------------------------------------------------------------------79
# Copyright (c) 2012 RedRover
# ----------------------------------------------------------------------------
def page_url(page, obj = nil)
  url = case page
    when 'home' then '/'
    when 'featured events' then '#/featured'
    when 'browse all events' then '#/browse/events'
    when 'browse all places' then '#/browse/places'
    when 'browse publishers' then '#/fun'
    when 'my redrover' then '/my'
    when 'settings' then '#/settings'
    else raise "Unknown page_url: #{page}"
  end
end
