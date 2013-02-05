V3RedroverWebsite.BrowsePublisherRowView = Ember.View.extend
  classNames: ['row']
  template: Em.Handlebars.compile("{{#each this}}{{view V3RedroverWebsite.BrowsePublisherView}}{{/each}}")
