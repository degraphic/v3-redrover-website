V3RedroverWebsite.SearchPlacesPanelView = V3RedroverWebsite.baseView.extend
  templateName: 'search_places_panel'
  isTriggeredMultiCategories: false
  categories_ids: []
  most_starred: false
  by_followers: false
  filterDistance:
    distance: 5

  #callbacks
  didInsertElement:->
    @activeCurrentLocation()
    @activeLocationAutocomplete "locationAutocomplete", ()=>
      location = this.getPlace().geometry.location
      @set("lat_lon", "#{location.Ya},#{location.Za}")

  # observers
  locationChanged: ( ()->
    @set("lat_lon", "") if $.trim(@get("location")) is ""
  ).observes 'location'

  # Functions
  selectedCategory: (event)->
    option = $(event.target)
    if option.hasClass("checked")
      @get("categories_ids").push(event.context)
    else
      categories = _.reject @get("categories_ids"), (num) -> return num == event.context 
      @set("categories_ids", categories)
    return false

  addMileDistance: (event)->
    distance = $(event.target).data("distance")
    @set("filterDistance.distance", distance )

    distance = "10+" if distance == 10000
    $("#distanceTrigger").html  distance + " MI <span class='caret'/>"

  refreshMultiOption: ()->
    if (  $("#categories li").length > 0 && @get("isTriggeredMultiCategories") is false)
      $.startMultiDropdown()
      @set("isTriggeredMultiCategories", true)

  filter: ()->
    @searchResults()

  searchResults:() ->
    @filterDistance["lat_lon"]= V3RedroverWebsite.currentUser.get("currentLatLong") if @filterDistance["lat_lon"] is undefined
    @filterDistance["lat_lon"]= @get("lat_lon") if @isLocationActive()
    query = jQuery.extend( query || {} , {categories_ids: @get("categories_ids").join(",")} ) if @get("categories_ids").length > 0
    query = jQuery.extend( query || {}, {most_starred: true} ) if @get("most_starred")
    query = jQuery.extend( query || {}, {by_followers: true} ) if @get("by_followers")
    query = jQuery.extend( query || {}, @filterDistance ) unless  $.isEmptyObject @filterDistance
    @get("controller").find(query)

  isLocationActive: ()->
    $.trim(@get("lat_lon")) isnt ""
 
