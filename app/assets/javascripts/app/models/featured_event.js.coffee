V3RedroverWebsite.FeaturedEvent = DS.Model.extend {
  title: DS.attr('string')
  description: DS.attr('string')
  start_date: DS.attr('string')
  start_time: DS.attr('string')
  image_medium: DS.attr('string')
  image_original: DS.attr('string')
  starred_by_current_user: DS.attr('boolean')
  place: DS.attr('json')
  publisher: DS.attr('json')
}

V3RedroverWebsite.FeaturedEvent.reopenClass {
  url: 'recommendation'
  findAllUrl: 'recommendations'
}
