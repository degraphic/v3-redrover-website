V3RedroverWebsite.UserController = Ember.ObjectController.extend {
  follow: -> @get('content').follow()

  unfollow: -> @get('content').unfollow()
}