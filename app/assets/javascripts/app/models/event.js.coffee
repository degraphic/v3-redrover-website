V3RedroverWebsite.Event = DS.Model.extend {
  title: DS.attr('string')
  description: DS.attr('string')
  start_date: DS.attr('string')
  start_time: DS.attr('string')
  start_datetime_with_utc_offset: DS.attr('string')
  image_medium: DS.attr('string')
  image_original: DS.attr('string')
  ticketing_url: DS.attr('string')
  starred_by_current_user: DS.attr('boolean')
  place: DS.attr('json')
  publisher: DS.attr('json')
  categories: DS.attr('json')
  start_datetime_with_utc_offset: DS.attr('date')
  
  fullDate: (->
    new Date( "#{@get("start_date")} #{@get("start_time")}" )
    ).property("start_time","start_date")
  comments: DS.hasMany('V3RedroverWebsite.EventComment') 

}

V3RedroverWebsite.Event.reopenClass {
  findAllUrl: 'events/search',
  saveUrl: 'events/%@/start'
}
