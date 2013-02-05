V3RedroverWebsite.AutocompleteResultsView = Ember.View.extend
  templateName: 'autocomplete_results'
  visibility: ( ->
    if @get('controller.results.isLoaded')
      "hide"
    else
      "icomoon-spinner"
  ).property('controller.results.isLoaded')

  goToFullSearchPage: ->
    V3RedroverWebsite.router.transitionTo('browseAll')
