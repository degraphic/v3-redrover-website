V3RedroverWebsite.SearchResultsView = Ember.View.extend
  templateName: 'search_results'
  visibility: ( ->
    if @get('controller.results.isLoaded')
      "hide"
    else
      "icomoon-spinner pull-left"
  ).property('controller.results.isLoaded')