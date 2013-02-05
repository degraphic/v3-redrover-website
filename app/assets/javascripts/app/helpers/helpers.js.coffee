# Return a view that formats `content` through the function `fn`.
# http://techblog.fundinggates.com/blog/2012/08/ember-handlebars-helpers-bound-and-unbound/

# Register a Handlebars helper that instantiates `view`.
# The view will have its `content` property bound to the
# helper argument.

registerViewHelper = (name, view) ->
  Ember.Handlebars.registerHelper(name, (property, options) ->
    options.hash.contentBinding = property
    Ember.Handlebars.helpers.view.call(@, view, options)
  )

inlineFormatter = (fn) ->
  Ember.View.extend({
    tagName: 'span'
    template: Ember.Handlebars.compile('{{view.formattedContent}}')

    formattedContent: (->
      if (@get('content') != null)
        fn(@get('content'))
    ).property('content')
  })

registerViewHelper 'formatDate', inlineFormatter((content) ->
  $D(content).strftime("%A, %b %eth")
)

registerViewHelper 'formatTime', inlineFormatter((content) ->
  $D(content).strftime("%#I:%M %p")
)

registerViewHelper 'isLoggedin', inlineFormatter((content) ->
  V3RedroverWebsite.currentUser.get("loggedin")
)

registerViewHelper 'firstCategory', inlineFormatter((categories) ->
  return "" if categories is undefined || categories.length <= 0
  categories[0].name
)

Handlebars.registerHelper('if_currentUser', ( (block) ->
    if V3RedroverWebsite.currentUser.isLoggedin()
      return block.fn()
  )
)