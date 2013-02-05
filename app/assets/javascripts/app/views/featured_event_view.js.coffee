V3RedroverWebsite.FeaturedEventView = Ember.View.extend( V3RedroverWebsite.StarrableModelView,
  {
    starrableResources: 'events'
    templateName: (->
      LARGE_TEMPLATE_MOD = 6
      LARGE_TEMPLATE = 'featured_event_large'
      SMALL_TEMPLATE = 'featured_event_small'

      template = SMALL_TEMPLATE  #default
      
      index = @get('_parentView.contentIndex')
      if typeof index != undefined
        if index == 0 || (index % LARGE_TEMPLATE_MOD == 0)
          template = LARGE_TEMPLATE
        
      template
    ).property('content.template'),

    didInsertElement: ->
      @set("parentView.isLoaded", true)
  }
)
