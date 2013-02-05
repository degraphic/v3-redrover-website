V3RedroverWebsite.StarredEvent = V3RedroverWebsite.Event.extend {
  image_thumb: DS.attr('string')
}

V3RedroverWebsite.StarredEvent.reopenClass {
  findAllUrl: 'events/starred_events'
  url: 'event'
}
