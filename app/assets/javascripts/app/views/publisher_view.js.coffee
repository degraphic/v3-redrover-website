V3RedroverWebsite.PublisherView = Ember.View.extend
  templateName: 'publisher'
  
  follow: -> @get('controller').follow()
  
  unfollow: -> @get('controller').unfollow()
