V3RedroverWebsite.AlertController = Ember.ObjectController.extend
	# Valid Types are : default, error, success, info
	type: 'default'
	message: ''
	active: false

	display: (message, type)->
		@set('active', false)

		@set('type', type)
		@set('message', message)
		@set('active', true)