V3RedroverWebsite.BrowsePublisherView = Ember.View.extend
  classNames: ['span5']
  templateName: 'browse_publisher'
  didInsertElement: ->
    @set("parentView.parentView.isLoaded", true)