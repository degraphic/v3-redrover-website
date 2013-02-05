V3RedroverWebsite.PublisherRowView = Ember.View.extend
  templateName: 'publisher_row'
  defaultPage: 1
  defaultPerPage: 3
  firstPage: (()->
    return true if @get("defaultPage") is 1
    false
    ).property("defaultPage")
  hasNext: (()->
      events = @get("context.events.content")
      return true if events isnt undefined && events.length isnt 0
      false
    ).property("context.events.@each")
  follow: -> @get('context').follow()
  unfollow: -> @get('context').unfollow()
  didInsertElement: ()->
    @searchEvents()
  searchEvents: ->
    events = V3RedroverWebsite.Event.find({ publishers_ids: @get('context.id'), page: @get("defaultPage"), per_page: @get("defaultPerPage") })
    @set("context.events", events)
  defaultPageChange: (()->
      @searchEvents()
    ).observes("defaultPage")
  nextPage: ->
    @set( "defaultPage", @get("defaultPage") + 1 )
  backPage: ->
    @set( "defaultPage", @get("defaultPage") - 1 )