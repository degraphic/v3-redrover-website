V3RedroverWebsite.AutocompleteResultsController = Ember.ObjectController.extend
  text: ""

  results:( () ->
    if Ember.empty(@get('text'))
      return []
    else
      return V3RedroverWebsite.Event.find({ text: @get('text'), per_page: 8 })
  ).property('text')