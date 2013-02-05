V3RedroverWebsite.StarredPlace = V3RedroverWebsite.Place.extend {
  street_address: DS.attr('string')
  phone_number: DS.attr('string')
  categories: DS.attr('json')
}

V3RedroverWebsite.StarredPlace.reopenClass {
  findAllUrl: 'places/starred_places'
  url: 'place'
}