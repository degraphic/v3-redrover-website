RoverRoute = Ember.Route.extend {
  enter: (router) ->
    window.scrollTo(0,0)
    @_super(router)
}

RestrictedRoute = RoverRoute.extend
  enter: (router) ->
    Ember.run.next(
      ->
        unless V3RedroverWebsite.get('currentUser.isLoggedIn')
          router.transitionTo('root.featuredEvents')
    )


V3RedroverWebsite.Router = Ember.Router.extend
  enableLogging: true
  goToFeaturedEvents: Ember.Route.transitionTo('root.featuredEvents')
  goToEvent: Ember.Route.transitionTo('root.event')
  goToPlace: Ember.Route.transitionTo('root.place')
  goToBrowseEvents: Ember.Route.transitionTo('root.browseEvents')
  goToBrowsePlaces: Ember.Route.transitionTo('root.browsePlaces')
  goToMyRedrover: Ember.Route.transitionTo('root.myRedrover')
  goToPublishers: Ember.Route.transitionTo('root.publishers')
  goToPublisher: Ember.Route.transitionTo('root.publisher')
  goToSettings: Ember.Route.transitionTo('root.settings')
  goToUser: Ember.Route.transitionTo('root.user')
  goToBrowseActivities: Ember.Route.transitionTo('root.activities')

  root: Ember.Route.extend
    index: RoverRoute.extend
      route: '/'
      redirectsTo: 'root.featuredEvents'

    featuredEvents: RoverRoute.extend
      route: '/featured'
      connectOutlets: (router) ->
        router.set('applicationController.currentNavigation', 'featured')
        router.get('applicationController').connectOutlet({
          name: 'featuredEvents'
          context: V3RedroverWebsite.FeaturedEvent.find()
        })

    myRedrover: RestrictedRoute.extend
      route: '/my'
      connectOutlets: (router) ->
        router.set('starredEventsController.content', V3RedroverWebsite.StarredEvent.find())
        router.set('starredPlacesController.content', V3RedroverWebsite.StarredPlace.find())

        router.set('applicationController.currentNavigation', 'myRedrover')
        router.get('applicationController').connectOutlet({
          name: 'myRedrover'
        })

    publishers: RoverRoute.extend
      route: '/fun'
      connectOutlets: (router) ->
        router.set('applicationController.currentNavigation', 'browsePublishers')
        router.get('applicationController').connectOutlet({
          name: 'browsePublishers'
          context: V3RedroverWebsite.Publisher.find()
        })

    browseEvents: RoverRoute.extend
      route: '/browse/events'
      connectOutlets: (router) ->
        router.set('applicationController.currentNavigation', 'browseEvents')
        query = 
          "start_date[from]": Date.current().strftime "%Y-%m-%dT00:00:00-05:00"
          "start_date[to]":   Date.current().strftime "%Y-%m-%dT23:00:00-05:00"
          "lat_lon": V3RedroverWebsite.currentUser.get("currentLatLong")
          "action_date": "today"
          "most_starred": true
          "distance": "5mi"
        router.get('applicationController').connectOutlet('browseEvents', V3RedroverWebsite.Event.find(query))
    
    browsePlaces: RoverRoute.extend
      route: '/browse/places'
      connectOutlets: (router) ->
        router.set('applicationController.currentNavigation', 'browsePlaces')
        router.get('applicationController').connectOutlet('browsePlaces')

    browseAll: RoverRoute.extend
      route: '/browse/all'
      connectOutlets: (router) ->
        router.set('applicationController.currentNavigation', null)
        router.get('applicationController').connectOutlet('searchResults')
    autocomplete: RoverRoute.extend
      connectOutlets: (router) ->
        router.get('applicationController').connectOutlet('autocompleteResult', 'autocompleteResults')
    event: RoverRoute.extend
      route: '/events/:id'
      deserialize: (router, context) ->
        V3RedroverWebsite.Event.find(context.id)
      serialize: (router, context) ->
        id: context.id
      
      connectOutlets: (router, event) ->
        router.set('applicationController.currentNavigation', null)
        router.get('eventController').set('content', event)
        router.get('applicationController').connectOutlet('event', event)

    place: RoverRoute.extend
      route: '/places/:id'
      deserialize: (router, context) ->
        V3RedroverWebsite.Place.find(context.id)
      serialize: (router, context) ->
        id: context.id

      connectOutlets: (router, place) ->
        router.set('applicationController.currentNavigation', null)
        router.get('placeController').set('content', place)
        router.get('applicationController').connectOutlet('place', place)

    publisher: RoverRoute.extend
      route: '/publishers/:id'
      deserialize: (router, context) ->
        V3RedroverWebsite.currentUser.refreshFollowedPublishers()
        V3RedroverWebsite.Publisher.find(context.id)
      serialize: (router, context) ->
        id: context.id

      connectOutlets: (router, publisher) ->  
        router.set('applicationController.currentNavigation', null)
        router.get('publisherController').set('content', publisher)
        router.get('applicationController').connectOutlet('publisher', publisher)

    settings:  RestrictedRoute.extend
      route: '/settings'
      connectOutlets: (router)->
        router.set('applicationController.currentNavigation', null)
        router.get('applicationController').connectOutlet("userSettings")  
    authenticate: (router) ->
      router.get('authenticationController').authenticate()
    becomeAuthenticated: (router) ->
      router.transitionTo('myRedrover')

    user: RoverRoute.extend
      route: '/users/:id'

      serialize: (router, context) ->
        id: context.id

      connectOutlets: (router, params) ->
        user = V3RedroverWebsite.User.find(params.id)
        router.set('applicationController.currentNavigation', null)
        router.get('userController').set('content', user)
        router.get('applicationController').connectOutlet('user', user)

    activities: RestrictedRoute.extend
      route: '/activities'

      connectOutlets: (router) ->
        activities = V3RedroverWebsite.Activity.find()
        categories = V3RedroverWebsite.Category.find()

        router.set('applicationController.currentNavigation', null)
        router.get('applicationController').connectOutlet('browseActivities', activities)
