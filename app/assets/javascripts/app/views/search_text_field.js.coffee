V3RedroverWebsite.SearchTextField = Ember.TextField.extend(Ember.TargetActionSupport, {
  attributeBindings: ['accept', 'autocomplete']
  insertNewline: ->
    @triggerAction()
})