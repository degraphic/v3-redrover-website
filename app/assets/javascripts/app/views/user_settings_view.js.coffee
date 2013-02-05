V3RedroverWebsite.UserSettingsView = Ember.View.extend
  templateName: "user_settings"
  controller: "user_settings"
  hasErrorPassword: false
  settingSaved: false
  
  password:
    current_password: null
    new_password: null
    confirm_new_password: null
  errorPassword: null

  privacyOptions:
    [
      { label: "Public", value: "all" }
      { label: "Approved Followers", value: "friends" }
      { label: "Private", value: "none" }
    ]
  
  firstNameBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.first_name')
  lastNameBinding:  Ember.Binding.oneWay('V3RedroverWebsite.currentUser.last_name')
  userEmailBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.email')
  zipcodeBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.zipcode')

  gender: (->
    if V3RedroverWebsite.get('currentUser.gender') == "M" then true else false
  ).property()

  feedsPrivacyBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.feeds_i_follow_privacy')
  eventsPrivacyBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.my_saved_events_privacy')
  placesPrivacyBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.my_saved_places_privacy')
  followingPrivacyBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.people_i_follow_privacy')
  followersPrivacyBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.following_me_privacy')

  saveUserSettings: ()->
    @get("controller").updatePersonalInformation {
      firstName: @get('firstName')
      lastName: @get('lastName')
      email: @get('userEmail')
      gender: @get('genderToggle.value')
      zipcode: @get('zipcode')
    }, ()=>
      V3RedroverWebsite.router.get('alertController').display(
        'Your settings have been updated!', 'success')
      V3RedroverWebsite.currentUser.loadFromCookie()

  changePassword: ()->
    errorMessage = @validFormPassword()
    that = @
    if errorMessage isnt undefined
      @set("hasErrorPassword", true)
      @set("errorPassword", errorMessage)
      return true

    @get("controller").changePassword( @get("password"), (model)->
        response = model.get("createdResponse")
        if response.code is "API_ERROR"
          that.set "hasErrorPassword", true
          that.set "errorPassword", response.message
        else
          V3RedroverWebsite.router.get('alertController').display(
            'Your password has been updated!', 'success')
          that.resetPasswordForm()
      )

  validFormPassword: ()->
    @set "hasErrorPassword", false
    @set "errorPassword", ""
    return "Current Password can't be blank" if $.trim(@get("password.current_password")) is ""
    return "Incorrect Password Confirmation" if @get("password.new_password") isnt @get("password.confirm_new_password")
    return "New Password can't be blank" if $.trim(@get("password.new_password")) is ""
    
  resetPasswordForm: ()->
    @set "password.current_password", ""
    @set "password.confirm_new_password", ""
    @set "password.new_password", ""
    $("#password-modal").modal("hide")

  savePrivacyClicked: ()->
    @get('controller').savePrivacyOptions {
      feedsPrivacy: @get('feedsPrivacy')
      eventsPrivacy: @get('eventsPrivacy')
      placesPrivacy: @get('placesPrivacy')
      followingPrivacy: @get('followingPrivacy')
      followersPrivacy: @get('followersPrivacy')
    }, ()=>
      V3RedroverWebsite.router.get('alertController').display(
        'Your privacy settings have been updated!', 'success')
      V3RedroverWebsite.currentUser.loadFromCookie()

    @$('#privacy-modal').modal('hide')