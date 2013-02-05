# This could either be places or events, indicated by the recommendation_type
V3RedroverWebsite.BeforeAndAfter = DS.Model.extend {
  title: DS.attr('string')
  name: DS.attr('string')
  city: DS.attr('string')
  state: DS.attr('string')
  image_medium: DS.attr('string')
  image_thumb: DS.attr('string')
  recommendation_type: DS.attr('string')
  description: DS.attr('string')
  place: DS.attr('json')
  publisher: DS.attr('json')
  lat_lon: DS.attr('string')
}

V3RedroverWebsite.BeforeAndAfter.reopenClass {
  url: 'nearby'
  findAllUrl: 'events/%@/nearby'
}