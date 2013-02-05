V3RedroverWebsite.FeaturedEventsView = V3RedroverWebsite.baseView.extend
  templateName: 'featured_events'
  searchModel: "FeaturedEvent"
  isLoaded: false
  visibility: ( ->
    if @get('isLoaded')
      return "hide"
  ).property('isLoaded')