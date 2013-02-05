V3RedroverWebsite.BrowseEventRowView = Ember.View.extend
  classNames: ['row']
  template: Em.Handlebars.compile("{{#each this}}{{view V3RedroverWebsite.BrowseEventView}}{{/each}}")
