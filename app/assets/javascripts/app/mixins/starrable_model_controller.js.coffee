V3RedroverWebsite.StarrableModelController = Ember.Mixin.create
  star: (event, starrableResources) ->
    context_id = if event.context then event.context.id else @get('content.id')
    me = @
    V3RedroverWebsite.currentUser.canonicalUserAction(
      url: "/#{starrableResources}/#{context_id}/star"
      success: (json, ds_model) ->
        if json.status == "success"
          if event.context
            event.context.set('starred_by_current_user', true)
          else
            me.set('content.starred_by_current_user', true)
    )
  unstar: (event, starrableResources) ->
    context_id = if event.context then event.context.id else @get('content.id')
    me = @
    V3RedroverWebsite.currentUser.canonicalUserAction(
      url: "/#{starrableResources}/#{context_id}/unsave"
      success: (json, ds_model) ->
        if json.status == "success"
          if event.context
            event.context.set('starred_by_current_user', false)
          else
            me.set('content.starred_by_current_user', false)
    )