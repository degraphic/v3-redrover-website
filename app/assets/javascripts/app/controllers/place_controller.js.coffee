V3RedroverWebsite.PlaceController = Ember.ObjectController.extend V3RedroverWebsite.StarrableModelController, 
  # nearbyEvent: (() ->
  #   V3RedroverWebsite.NearbyEvent.find({ parent_id: @get('content.id') })
  # ).property('content')
  comments: (()->
    @get("controllers.commentsController").getComments("PlaceComment", @get("content.id"))
    @get("controllers.commentsController.comments_data")
    ).property("controllers.commentsController.comments_data")
  loadPublishers: ()->
    return @get("content").loadPublishers() if @get("content")._data
    place = V3RedroverWebsite.Place.createRecord(@get("content"))
    place.loadPublishers()
    @set("content",  place)
  events: ( () ->
    return V3RedroverWebsite.Event.find({ places_ids: @get('content.id'), per_page: 9 })
  ).property('content.id')

