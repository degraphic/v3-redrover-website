V3RedroverWebsite.NavigationView = Ember.View.extend
  templateName: 'navigation'
  selectedBinding: 'controller.currentNavigation'

  NavLinkView: Ember.View.extend {
      tagName: 'li',
      classNameBindings: 'btnGroup isActive:active'.w(),
      isActive: (-> 
        @get('item') == @get('parentView.selected')
      ).property('item', 'parentView.selected')
  }
  