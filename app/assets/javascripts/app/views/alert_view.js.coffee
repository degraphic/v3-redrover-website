V3RedroverWebsite.AlertView = Ember.View.extend
	templateName: 'alert'
	classNames: ['alert']
	controllerBinding: 'V3RedroverWebsite.router.alertController'
	classNameBindings: ['alertType', 'active:show:hide']

	didInsertElement:->
		$("body").on "click", (event)=> unless $(event.target).hasClass("alert") then @hide()

	alertType: (->
		type = @get('controller').type
		switch type
			when "default" then "alert-default"
			when "error" then "alert-error"
			when "info" then "alert-info"
			when "success" then "alert-success"
		).property('controller.type')

	active: (->
		@get('controller').active
		).property('controller.active')

	hide: ->
		@get('controller').set('active', false)