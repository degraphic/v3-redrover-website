V3RedroverWebsite.EventView = Ember.View.extend V3RedroverWebsite.StarrableModelView,
  templateName: 'event'
  isLoadedCalendar: false
  starrableResources: 'events'
  controllerBinding: 'V3RedroverWebsite.router.eventController'
  currentUserBinding: "V3RedroverWebsite.currentUser"


  #callbacks
  render: ->
    @_super.apply(@, arguments)
    @_loadMap()

  didInsertElement: ()->
    @initializeOptionTriggers()
    @loadStartOptions()
  #observers
  loadEvent: ( ()->
    @_loadMap()
  ).observes("context.isLoaded")

  onLogin: (()->
    Ember.run.next @, -> @loadStartOptions()
  ).observes("currentUser.isLoggedIn")

  #functions
  loadStartOptions: ()->
    $('span.icomoon-star').popover({
      placement:'bottom',
      html: true,
      title: false
    })
    

  initializeOptionTriggers: ()->
    $("body").on("click", "#add-to-calendar", (event)=>
      @toggleCalendar()
      event.stopPropagation()
    )

    $("body").on("click", "#save-event", (event)=>
      @star_model(event)
      event.stopPropagation()
    )

    $("body").on("click", (event)=>
      if !$(event.target).hasClass("icomoon-star") && $(".popover").length > 0
        $('span.icomoon-star').click()
        event.stopPropagation()
    )

    $('body').on "click", "span.icomoon-star", => @set("isLoadedCalendar", false)

  starredLabel: ( ->
    if @get('context.starred_by_current_user') == true
      return 'Unsave Event'
    else 
      return 'Save On RedRover'
  ).property('context.starred_by_current_user')

  #This function below will initialize the dropdown with the current event starred state
  #but this doesn't allow to refresh the state label due twitter bootstrap popover doesn't allow to refresh the content once the popover is open.
  calendarDropDown: ( ->
    return "<ul id='save-calendar'class='calendar'><li><a id='save-event' href='javascript:void(0)'>#{@get('starredLabel')}</a></li><li class='divider'></li><li id='add-to-calendar'><a>Add to Calendar Tool</a><b class='caret'></b></li><div class='add-to-calendar'></div></ul>"
  ).property('starredLabel')

  calendarDropDownDidChange: ( ->
    $('#save-event').html(@get('starredLabel'))
  ).observes('calendarDropDown')

  toggleCalendar: ->
    calendarPopup = $("#add-to-calendar")
    if(calendarPopup.hasClass('open'))
      $('.add-to-calendar').slideUp 200
      $('#save-calendar b.caret').removeClass 'up'
      calendarPopup.removeClass 'open'
    else
      $('.add-to-calendar').slideDown 200
      $('#save-calendar b.caret').addClass 'up'
      calendarPopup.addClass 'open'

    @loadCalendar() unless @get("isLoadedCalendar")

  _loadMap: ->
    load = =>
      map = $('.map')[0]
      coords = @get('context.place.lat_lon')
      data = @get('context.place')
      if window.googleMapsIsInitialized == true and map
        [latitude, longitude] = coords.split(',')
        location = new google.maps.LatLng(latitude, longitude)
        mapOptions = {
          zoom: 12
          center: location
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        map = new google.maps.Map($('.map')[0], mapOptions)
        marker = new google.maps.Marker({
          title: @get('context.place').name
          position: location,
          map: map
        })
      else
        setTimeout load, 100
    load()

  loadCalendar: ->
    calendarContainer = $("#icalendar-container")
    currentEvent = @get("controller.content")
    return false if currentEvent.get("title") is null
    dateEvent = 
      start: currentEvent.get("start_datetime_with_utc_offset")
      end: currentEvent.get("start_datetime_with_utc_offset")
      title: currentEvent.get("title")
      description: "Please see details bellow: \n #{location.href}"
      location: currentEvent.get("place.name")
      echoUrl: "/calendar/export.ics"
    $('#icalendar-container').icalendar(dateEvent);
    @set("isLoadedCalendar", true)
    $("#icalendar-container .icalendar_list li").clone().appendTo ".add-to-calendar"

 
