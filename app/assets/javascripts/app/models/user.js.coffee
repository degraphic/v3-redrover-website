V3RedroverWebsite.User = DS.Model.extend {
  first_name: DS.attr('string')
  last_name: DS.attr('string')
  email: DS.attr('string')
  gender: DS.attr('string')
  authentication_token: DS.attr('string')
  profile_picture_medium: DS.attr('string')
  profile_picture_thumb: DS.attr('string')
  followedUsers: []
  bio: DS.attr('string')
  starred_by_current_user: DS.attr('boolean')
  full_name: (-> "#{@get('first_name')} #{@get('last_name')}").property('first_name', 'last_name')
  followedPublishers: []

  # Callbacks

  # Dinamic Properties
  isLoggedIn: (->
    if @get('authentication_token')
      true
    else
      false
  ).property('authentication_token')

  full_name: (->
    fullName = []
    if @get('first_name')
      fullName.push @get('first_name')
    if @get('last_name')
      fullName.push @get('last_name')

    fullName.join ' '
  ).property('first_name', 'last_name')

  abbreviated_name: (->
    if @get('last_name')
      "#{@get('first_name')} #{@get('last_name')[0]}."
    else
      "#{@get('first_name')}"
  ).property('first_name', 'last_name')
  


  follow: ->
    @canonicalUserAction(
      url: "/users/#{@get('id')}/follow"
      type: 'POST'
      success: (json, ds_model) =>
        if json.status == "success"
          @set('starred_by_current_user', true)
        else
          alert 'There was an error processing your request. Please try again later.'
    )

  unfollow: ->
    @canonicalUserAction(
      url: "/users/#{@get('id')}/unfollow"
      type: 'POST'
      success: (json, ds_model) =>
        if json.status == "success"
          @set('starred_by_current_user', false)
        else
          alert 'There was an error processing your request. Please try again later.'
    )

  refreshFollowedUsers: ->
    token = $.cookie("rr_token")
    api = V3RedroverWebsite.Config.api
    url = "/users/following?auth_token=#{token}"

    $.ajax
      url: api.host+url+'&client_id='+api.client_id+'&client_secret='+api.client_secret
      type: 'GET'
      dataType: 'json'
      success: (response) =>
        users = _.map(response.data.users, (user) -> user.id)
        @set('followedUsers', users)
      error: (response) =>
        alert 'There was an error processing your request. Please try again later.'
        throw new Error(response.responseText)

  currentLatLong:(()->
    if @get("position") is undefined
      return   "40.768157,-73.9818055"
    @get("position.latitude")+","+@get("position.longitude")
  ).property("position")


  refreshFollowedPublishers: ->
    token = $.cookie("rr_token")
    api = V3RedroverWebsite.Config.api
    url = "/publishers/my_following_publishers?auth_token=#{token}"
    
    $.ajax
      url: api.host+url+'&client_id='+api.client_id+'&client_secret='+api.client_secret
      type: 'GET'
      dataType: 'json'
      success: (response) =>
        publishers = _.map(response.data.publishers, (publisher) -> publisher.id)
        @set('followedPublishers', publishers)
      error: (response, textStatus, errorThrown) =>
        # for some reason the api seems to sometimes respond w/ an error when
        # it was actually successful
        realResponse = JSON.parse(response.responseText)
        if realResponse.status is 'success'
          @success(realResponse)
        else
          alert 'There was an error processing your request. Please try again later.'
          throw new Error(response.responseText)

  currentLatLong:(()->
    if @get("position") is undefined
      return   "40.768157,-73.9818055"
    @get("position.latitude")+","+@get("position.longitude")
  ).property("position")
  
 
  login: (email, password) ->
    @set('loginErrors', '')
    @canonicalUserAction {
      url: '/users/login'
      data: { user: { email: email, password: password } }
      success: (json, ds_model) =>
        if json.status == "success"
          @_saveLoginData(json.data.user)
        else
          @set('loginErrors', 'Incorrect username or password')
    }

  loginWithFacebook: ->
    @set('loginErrors', '')
    loginToRR = (fbAuth, fbData) =>
      @canonicalUserAction {
        url: '/users/login_with_social'
        data:
          user:
            first_name: fbData.first_name
            last_name: fbData.last_name
            email: fbData.email
            profile_picture: "http://graph.facebook.com/"+fbData.id+"/picture?type=large"
          token: fbAuth.authResponse.accessToken
          uid: fbData.id
          provider: "facebook"
        success: (json, ds_model) =>
          if json.status == "success"
            @_saveLoginData(json.data.user)
      }
    FB.getLoginStatus( (response) ->
      if response.status != "connected"
        FB.login (fbAuth) ->
          if fbAuth.authResponse
            FB.api '/me', (fbData) ->
              loginToRR(fbAuth, fbData)
      else
        FB.api '/me', (fbData) ->
          loginToRR(response, fbData)
    )

  loginWithTwitter: ->
    @set('loginErrors', '')
    loginToRR = (e, user) =>
      @canonicalUserAction {
        url: '/users/login_with_social'
        data:
          user:
            name: user.name
            profile_picture: user.profile_image_url
          token: user.id
          uid: user.id
          provider: "twitter"
        success: (json, ds_model) =>
          if json.status == "success"
            @_saveLoginData(json.data.user)
      }
    twttr.anywhere (T) ->
      T.bind("authComplete", loginToRR)
      T.signIn()

  signup: (userData) ->
    @set('signupErrors', '')
    @canonicalUserAction {
      url: '/users'
      data: 
        user: userData
      success: (json, ds_model) =>
        if json.status == "success"
          @_saveLoginData(json.data.user)
        else
          @set('signupErrors', 'Error signing up')
    }

  logout: ->
    fields = ['authentication_token', 'first_name', 'last_name', 'email', 
              'profile_picture_medium', 'profile_picture_thumb']
    @set(field, null) for field in fields
    $.cookie("rr_token", null)
    
  canonicalUserAction: (options) ->
    me = @
    request_type = options.type || 'POST'
    api = V3RedroverWebsite.Config.api
    $.ajax(
      url: api.host+options.url+'?client_id='+api.client_id+'&client_secret='+api.client_secret+'&auth_token='+api.auth_token
      type: request_type
      dataType: 'json'
      data: options.data
      success: (json) ->
        options.success(json, me)
    )
  
  _saveLoginData: (userData, token) ->
    token ?= userData.authentication_token
    
    @setProperties(userData)
    @set('authentication_token', token)
    V3RedroverWebsite.Config.api.auth_token = token
    $.cookie("rr_token", token)
    @refreshFollowedPublishers()
    
    
  loadFromCookie: ->
    token = $.cookie("rr_token")
    return unless token

    V3RedroverWebsite.Config.api.auth_token = token
    url = '/users/current_user_info?auth_token='+token
    api = V3RedroverWebsite.Config.api

    $.ajax(
      url: api.host+url+'&client_id='+api.client_id+'&client_secret='+api.client_secret
      type: 'GET'
      dataType: 'json'
      success: (json) =>
        # We might have a bad cookie.  Yuck!
        if json.code != 'API_ERROR'
          @_saveLoginData(json.data.user, token)

    )
}


