V3RedroverWebsite.UserView = Ember.View.extend
  templateName: 'user'

  follow: -> @get('controller').follow()

  unfollow: -> @get('controller').unfollow()