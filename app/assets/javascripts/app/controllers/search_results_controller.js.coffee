V3RedroverWebsite.SearchResultsController = Ember.ObjectController.extend
  searchCriteria: ""

  results:( () ->
    if Ember.empty(@get('searchCriteria'))
      return []
    else
      V3RedroverWebsite.Event.find({ text: @get('searchCriteria') })
  ).property('searchCriteria')

