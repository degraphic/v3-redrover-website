V3RedroverWebsite.BrowsePublishersView = Ember.View.extend
  templateName: 'browse_publishers'
  isLoaded: false
  visibility: ( ->
    if @get('isLoaded')
      return "hide"
  ).property('isLoaded')





