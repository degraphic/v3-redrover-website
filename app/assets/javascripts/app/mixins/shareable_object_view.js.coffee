V3RedroverWebsite.ShareableObjectView = Ember.Mixin.create
  shareObject: (e) ->
    @get('controller').share(e, @get('shareableResources'))