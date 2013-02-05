V3RedroverWebsite.MyRedroverView = Ember.View.extend
	templateName: 'my_redrover'
	controllerBinding: 'V3RedroverWebsite.router.myRedroverController'
	userSettingsBinding: 'V3RedroverWebsite.router.userSettingsController'
	isEditing: false

	toggleEdit: ->
		@set('isEditing', !@get('isEditing'))

	saveUserProfile: ->
		@.get('userSettings').updatePersonalInformation {
				firstName: @get('firstNameField').value
				lastName: @get('lastNameField').value
				bio: @get('bioField').value
			}, () ->

		@toggleEdit()