V3RedroverWebsite.UserHeaderView = Ember.View.extend
  templateName:(() ->
    if @get('isLoggedIn')
      "current_user_header"
    else
      "login_signup_header"
  ).property('isLoggedIn')

  didInsertElement: ->
    $('body').on 'click', -> $('#dropdown-login, #user-dropdown').hide()

    
  currentUserBinding: 'V3RedroverWebsite.currentUser'
  isLoggedInBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.isLoggedIn')
  loginErrorsBinding: 'V3RedroverWebsite.currentUser.loginErrors'
  signupErrorsBinding: 'V3RedroverWebsite.currentUser.signupErrors'
  
  #Observers
  onLoginStatusChange: (->
    # General, hide in case it was open
    $('#signup-modal').modal('hide')
  ).observes('isLoggedIn')

  toggleLogin: (event)->
    $('#dropdown-login').toggle()
    event.stopPropagation();

  showSignUp: ->
    @set('password', null)
    @set('password_confirmation', null)
    $('#signup-modal').modal();
    $('.signup-form').hide()

  closeSignUp: ->
    $('#signup-modal').modal('hide')

  showSignupForm: ->
    $('.signup-form').show()
    
  login: ->
    @get('currentUser').login(@get('email'), @get('password'))

  facebookLogin: ->
    @get('currentUser').loginWithFacebook()

  twitterLogin: ->
    @get('currentUser').loginWithTwitter()

  signup: ->
    @get('currentUser').signup({
      email: @get('email')
      password: @get('password')
      password_confirmation: @get('password_confirmation')
      first_name: @get('first_name')
      last_name: @get('last_name')
    })

  logOut: ->
    @get('currentUser').logout()
    FB.logout()
    twttr.anywhere.signOut();
    V3RedroverWebsite.router.transitionTo('root.featuredEvents')
    @set("email", "")
    @set("password", "")

  toggleUserMenu: ->
    $('#user-dropdown').toggle()

  _templateChanged:( () ->
    @rerender()
  ).observes('templateName')


