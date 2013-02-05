V3RedroverWebsite.EventController = Ember.ObjectController.extend V3RedroverWebsite.StarrableModelController, V3RedroverWebsite.ShareableObjectController, {
  resourcesName: "events"
  beforeAndAfter: (() ->
    V3RedroverWebsite.BeforeAndAfter.find({ parent_id: @get('content.id') })
  ).property('content')

  comments: (()->
   @get("controllers.commentsController").getComments("EventComment", @get("content.id"))
   @get("controllers.commentsController.comments_data")
  ).property("content", "controllers.commentsController.comments_data")
}
