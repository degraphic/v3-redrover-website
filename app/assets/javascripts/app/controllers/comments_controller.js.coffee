V3RedroverWebsite.CommentsController = Ember.ArrayController.extend
  comments_data: []

  addComment: (commentType, content, contentId)->
    parameters =
      id: contentId
      comment:  
        content: content
    comment = V3RedroverWebsite[commentType].createRecord {  parameters: parameters, id: contentId }
    that = @  

    comment.didCreate = ()->
      that.getComments( commentType, contentId )
    comment.store.commit()

  getComments: (commentType, contentId)->
    @set("comments_data", V3RedroverWebsite[commentType].find({ parent_id: contentId }) )  

