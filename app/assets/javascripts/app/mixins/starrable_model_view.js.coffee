V3RedroverWebsite.StarrableModelView = Ember.Mixin.create

  starredLabelDefault: ( ->
    if @get('context.starred_by_current_user') == true 
      return 'Unsave'
    else
      return 'Save'
  ).property('context.starred_by_current_user')

  starredClass: ( ->
    if @get('context.starred_by_current_user') == true
      return 'icomoon-star active' 
    else 
      return 'icomoon-star gray'
  ).property('context.starred_by_current_user')

  star_model: (e) ->
    if @get('context.starred_by_current_user') == false
      @get('controller').star(e, @get('starrableResources'))
    else
      @get('controller').unstar(e, @get('starrableResources'))