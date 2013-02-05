V3RedroverWebsite.Category = DS.Model.extend {
  name: DS.attr('string')
  place: DS.belongsTo('V3RedroverWebsite.Place')
}

V3RedroverWebsite.Category.reopenClass {
  url: 'category'
  findAllUrl: 'categories'
}
