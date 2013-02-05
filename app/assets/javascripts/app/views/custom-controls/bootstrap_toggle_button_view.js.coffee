V3RedroverWebsite.BootstrapToggleButtonView = Ember.View.extend
  classNames: ['control']
  templateName: 'custom_controls/bootstrap_toggle_button'

  didInsertElement: ->
    self = @

    @$().toggleButtons(
      width: 220,
      label:
        enabled: @get('checkedText'),
        disabled: @get('unCheckedText')
      # Propagate changes from Toggle Button to Ember variable
      onChange: ($el, status, event)->
        self.set('checked', status)
    )

  # Propagate changes from Ember variable to Toggle Button
  updateControl: ->
    @$().toggleButtons('setState', @get('checked'))

  # Set value, switch Toggle Button UI based on 'checked'
  checkedChanged: (->
    @updateControl()
    @setNewValue()
  ).observes('checked')

  setNewValue: ->
    if @get('checked')
      @set('value', @get('checkedValue')) 
    else
      @set('value', @get('unCheckedValue'))