V3RedroverWebsite.PublisherCategory = DS.Model.extend {
  name: DS.attr('string')
  publisher: DS.belongsTo('V3RedroverWebsite.Publisher')
}

V3RedroverWebsite.PublisherCategory.reopenClass {
  url: 'category'
  findAllUrl: 'categories?type=publisher'
}
