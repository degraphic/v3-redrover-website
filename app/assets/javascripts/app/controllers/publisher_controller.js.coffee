V3RedroverWebsite.PublisherController = Ember.ObjectController.extend {
  events: (() ->
    V3RedroverWebsite.Event.find({ publishers_ids: @get('content.id') })
  ).property('content')
  
  follow: (publisher) -> @get('content').follow()
  
  unfollow: (publisher) -> @get('content').unfollow()
}
