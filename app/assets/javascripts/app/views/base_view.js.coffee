V3RedroverWebsite.baseView = Ember.View.extend

  addComment: (event)->
    content = $("#commentContent")
    if $.trim(content.val()) is ""
      alert "Description can't be blank" 
      return true
    @commentsController().addComment(@get("commentType"), content.val(), @parentViewController().get("content.id"))
    content.val ""
  parentViewController: ()->
    @get("parentView").get("controller")
  parentViewContent: ()->
    @get("parentView").get("controller").get("content")
  commentsController: ()->
    @get("controller").get("controllers.commentsController")
  activeLocationAutocomplete: (elementId, callback)->
    @input_location = document.getElementById elementId
    autocomplete = new google.maps.places.Autocomplete @input_location
    google.maps.event.addListener autocomplete, 'place_changed', callback
  visibility: ( ->
    if @get('controller.content.isLoaded')
      "hide"
    else
      "icomoon-spinner"
  ).property('controller.content.isLoaded')
  activeCurrentLocation: ->
    [latitude, longitude] = V3RedroverWebsite.currentUser.get("currentLatLong").split ','
    location = new google.maps.LatLng(latitude, longitude)
    map = new google.maps.Map(document.getElementById('map'), {
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: location,
        zoom: 15
      })
    request = 
      location: location
      radius: '5'

    service = new google.maps.places.PlacesService map 
    service.nearbySearch(request, (places)=>
        @set("currentLocation", places[0].name) if typeof(places[0]) != "undefined"
      )