V3RedroverWebsite.AuthenticationController = Ember.ObjectController.extend
  authenticated: (->
    V3RedroverWebsite.currentUser.get('isLoggedIn')
  ).property('V3RedroverWebsite.currentUser.isLoggedIn')
  
  authenticatedDidChange:( ->
    if @get('authenticated')
      @controllers.alertController.display('You are now logged in!', 'success')
  ).observes('authenticated')