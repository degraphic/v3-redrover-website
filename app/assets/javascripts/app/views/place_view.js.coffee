V3RedroverWebsite.PlaceView = Ember.View.extend V3RedroverWebsite.StarrableModelView,
  templateName: 'place'
  starrableResources: 'places'
  render: ->
    @_super.apply(@, arguments)
    @_loadMap()
  afterRender: ->
    @get("controller").loadPublishers()
  _loadMap: ->
    load = =>
      map = $('.map')[0]
      coords = @get('context.lat_lon')
      if window.googleMapsIsInitialized == true and map and coords
        [latitude, longitude] = coords.split(',')
        location = new google.maps.LatLng(latitude, longitude)
        mapOptions = {
          zoom: 12
          center: location
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        map = new google.maps.Map($('.map')[0], mapOptions)
        marker = new google.maps.Marker({
          title: @get('context.name')
          position: location
          map: map
        })
      else
        setTimeout load, 100
    load()