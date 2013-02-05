V3RedroverWebsite.SearchPanelView = V3RedroverWebsite.baseView.extend
  templateName: 'search_panel'
  filterDay: 
    action_date: "today"
  filterAge: {}
  filterDistance:
    distance: 5
  filterStarred:
    most_starred: false
  filterFollowers:
    by_followers: false

  isLocationAutocompleteActive: false
  locationChanged: ( ()->
    @set("lat_lon", "") if $.trim(@get("location")) is ""
  ).observes 'location'

  didInsertElement: ->
    $("#calendarDate").datepicker({showOn: 'button', buttonImageOnly: true, buttonImage: "/assets/transparent.png"})
# 
  # action
  todayEvents:(event)->
    @filterDay = @queryByDate "today", Date.current()
    @setActiveDate event.target
    @searchResults()
  tomorrowEvents: (event)-> 
    @filterDay = @queryByDate "tomorrow", Date.current().add(1, "days")
    @setActiveDate event.target
    @searchResults()
  weekendEvents:(event)->
    @filterDay = @queryByDate "weekend", Date.current(), @weekEndDate() 
    @setActiveDate event.target
    @searchResults()	
  showCalendarInput:(event) ->
    $("#calendarDate").datepicker "show"
  calendarEvents:->
    @setActiveDate event.target
    dateCalendar = $("#calendarDate").val()
    @filterDay = @queryByDate "calendar", $D(dateCalendar) 
    @searchResults()
  filterForBaby: (event)->
    @createAgeParameter event.target, "babytoddlers"
    @searchResults()
  filterForKidsAndTeens: (event)->
    @createAgeParameter event.target, "kidsandteens"
    @searchResults()
  filterForAdults: (event)->
    @createAgeParameter event.target, "adults"
    @searchResults()
  addMileDistance: (event) ->
    distance=  $(event.target).data("distance")
    @set("filterDistance.lat_lon", V3RedroverWebsite.currentUser.get("currentLatLong") )  
    @set("filterDistance.distance",  distance+"mi")
    
    distance = "10+" if distance == 10000
    $("#distanceTrigger").html  distance + " MI <span class='caret'/>"

    @searchResults()
  filter: ()->
    @searchResults()
  searchResults:() ->
    @filterDistance["lat_lon"]= V3RedroverWebsite.currentUser.get("currentLatLong") if @filterDistance["lat_lon"] is undefined
    @filterDistance["lat_lon"]= @get("lat_lon") if @isLocationActive()
    query = jQuery.extend( query || {} , @filterDay ) unless $.isEmptyObject @filterDay 
    query = jQuery.extend( query || {}, @filterAge ) unless  $.isEmptyObject @filterAge
    query = jQuery.extend( query || {}, @filterDistance ) unless  $.isEmptyObject @filterDistance
    query = jQuery.extend( query || {}, @filterStarred ) if @filterStarred.most_starred
    query = jQuery.extend( query || {}, @filterFollowers ) if @filterFollowers.by_followers
    @controllerParent().set "content", V3RedroverWebsite[@searchModel()].find(query)
  toggleMoreFilter: ->
    $("#moreFilter").toggleClass("hide")
    unless @isLocationAutocompleteActive
      that = @ 
      @activeLocationAutocomplete "locationAutocomplete", ()->
        location = this.getPlace().geometry.location
        that.set("lat_lon", "#{location.Ya},#{location.Za}")
        that.searchResults()
      @isLocationAutocompleteActive=true

  # Observers
  mostStarredEvents: (->
    @searchResults()
  ).observes('filterStarred.most_starred')

  followersEvents: (->
    @searchResults()
  ).observes('filterFollowers.by_followers')
      
  # functions
  isLocationActive: ()->
    @get("lat_lon")
    @get("location")
    @get("lat_lon") isnt "" && $.trim(@get("location")) isnt ""
  createAgeParameter:(button, target_action) ->
    if $(button).hasClass("active")
      $(button).removeClass "active"
      delete @filterAge["age_scope"]
    else
      @setActiveAge(button)
      @filterAge["age_scope"]= target_action
  setActiveDate:(button) ->
    $("#dateButtons button").removeClass("active")
    $(button).addClass "active"
  setActiveAge:(button) ->
    $("#ageButtons button").removeClass("active")
    $(button).addClass "active"
  searchModel: ->
    @get("parentView").get("searchModel")
  controllerParent: ->  
  	@get("parentView").get("controller")
  queryByDate: (action_date, startDate, finalDate = startDate)->
    console.log( finalDate )
    query =
      "action_date": action_date
      "start_date[from]": startDate.strftime "%Y-%m-%dT00:00:00-05:00"
      "start_date[to]":   finalDate.strftime "%Y-%m-%dT23:00:00-05:00"
  weekEndDate: ->
  	weekCurrentDay = Date.current().getDay()
  	weekDays = 6
  	restDays = weekDays - weekCurrentDay 
  	Date.current().add restDays, "days"
