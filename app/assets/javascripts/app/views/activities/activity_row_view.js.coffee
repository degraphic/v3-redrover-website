V3RedroverWebsite.ActivityRowView = Ember.View.extend
  templateName: ( ->
    switch @get('context.activity_type')
      when 'friendship accepted' then 'activities/friendship_accepted'
      when 'friendship declined' then 'activities/friendship_declined'
      when 'friend request sent' then 'activities/friend_request_sent'
      when 'event commented' then 'activities/event_commented'
      when 'place commented' then 'activities/place_commented'
      when 'saved place' then 'activities/saved_place'
      when 'saved event' then 'activities/saved_event'
      else false
  ).property('context.activity_type')

  _templateChanged:( () ->
    @rerender()
  ).observes('templateName')

  hisOrHer: (->
    switch @get('context.user.gender')
      when 'M' then 'his'
      else 'her'
  ).property('context.user.gender')
