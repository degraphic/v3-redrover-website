window.V3RedroverWebsite = Ember.Application.create(
  ready: ->
    currentUser = V3RedroverWebsite.User.createRecord()
    currentUser.loadFromCookie()
    @set('currentUser', currentUser)
      
    navigator.geolocation.watchPosition (pos) =>
      currentUser.set("position", pos.coords)

)

Ember.LOG_BINDINGS = true
