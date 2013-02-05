V3RedroverWebsite.SearchHeaderView = Ember.View.extend
  templateName: 'search_header'
  textBinding: 'V3RedroverWebsite.router.autocompleteResultsController.text'

  didInsertElement: ->
    me = @
    $('.navbar-search .search-query').focusout( ->
      $('.search_results').fadeOut(200)
      me.set('text', "")
    )
  search: ->
    V3RedroverWebsite.router.get('searchResultsController').set('searchCriteria', @get('text'))
    V3RedroverWebsite.router.transitionTo('browseAll')
    @set('text', "")
    $('.search_results').fadeOut(200)

  textDidChange:( () ->
    if $.trim(@get('text')).length > 3
      $('.search_results').fadeIn(200)
      V3RedroverWebsite.router.get('searchResultsController').set('searchCriteria', @get('text'))
      V3RedroverWebsite.router.transitionTo('autocomplete')
  ).observes('text')
