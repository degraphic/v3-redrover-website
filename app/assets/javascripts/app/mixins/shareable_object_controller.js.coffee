V3RedroverWebsite.ShareableObjectController = Ember.Mixin.create
  share: (event, shareableResources) ->
    context_id = if event.context then event.context.id else @get('content.id')
    me = @
    V3RedroverWebsite.currentUser.canonicalUserAction(
      url: "/#{shareableResources}/#{context_id}/share"
      success: (json, ds_model) ->
        if json.status == "success"
          if event.context
            #event.context.set('starred_by_current_user', true)
          else
            #me.set('content.starred_by_current_user', true)
    )