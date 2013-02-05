V3RedroverWebsite.Place = DS.Model.extend {
  name: DS.attr('string')
  city: DS.attr('string')
  state: DS.attr('string')
  zipcode: DS.attr('string')
  phone_number: DS.attr('string')
  lat_lon: DS.attr('string')
  starred_by_current_user: DS.attr('boolean')
  image_thumb: DS.attr('string')
  image_medium: DS.attr('string')
  categories: DS.attr('json')
  street_address: DS.attr("string")
  phone_number: DS.attr("string")
  publishers: []
  categories: DS.attr('json')

  loadPublishers: ()->
    that = @
    token = $.cookie("rr_token")
    api = V3RedroverWebsite.Config.api
    url = "/places/#{@id}/publishers?auth_token=#{token}"
    $.ajax
      url: api.host+url+'&client_id='+api.client_id+'&client_secret='+api.client_secret
      type: "GET"
      dataType: 'json'
      success: (response) ->
        that.set( "publishers", _.map(response.data.publishers, (publisher)-> V3RedroverWebsite.Publisher.createRecord(publisher) ))

}


V3RedroverWebsite.Place.reopenClass {
  findAllUrl: 'places/search'
}
