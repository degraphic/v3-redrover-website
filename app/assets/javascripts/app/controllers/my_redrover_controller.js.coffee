V3RedroverWebsite.MyRedroverController = Ember.ObjectController.extend
	content: []
	firstNameBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.first_name')
	lastNameBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.last_name')
	bioBinding: Ember.Binding.oneWay('V3RedroverWebsite.currentUser.bio')

	fullName: ( ->
		@get('firstName') + " " + @get('lastName')
	).property('firstName', 'lastName')