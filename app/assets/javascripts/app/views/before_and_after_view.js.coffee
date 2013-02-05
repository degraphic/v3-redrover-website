V3RedroverWebsite.BeforeAndAfterView = Ember.View.extend
  classNames: ['span5']
  
  templateName: (->
    if @_isEvent()
      'before_and_after_event'
    else
      'before_and_after_place'
  ).property()
  
  _isEvent: ->
    @get('context.recommendation_type') == 'Event'
