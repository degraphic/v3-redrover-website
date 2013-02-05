V3RedroverWebsite.PublisherRowController = Ember.ObjectController.extend 
  events: (() ->
    V3RedroverWebsite.Event.find({ publishers_ids: @get('content.id') })
  ).property('content')

 
 