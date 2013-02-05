V3RedroverWebsite.Publisher = DS.Model.extend {
  title: DS.attr('string')
  address: DS.attr('string')
  categories: DS.attr('json')
  description: DS.attr('string')
  image_medium: DS.attr('string')
  image_thumb: DS.attr('string')
  website_url: DS.attr('string')
  followedPublishersBinding:Ember.Binding.oneWay('V3RedroverWebsite.currentUser.followedPublishers')
  following: (->
    parseInt(@id) in @get('followedPublishers')
  ).property('followedPublishers')

  unfollow: -> @toggleFollow('unfollow')
  
  follow: -> @toggleFollow('follow')
  
  toggleFollow: (followOrUnfollow) ->
    following = if followOrUnfollow is 'follow' then true else false
    
    token = $.cookie("rr_token")
    api = V3RedroverWebsite.Config.api
    url = "/publishers/#{@id}/#{followOrUnfollow}?auth_token=#{token}"
    
    $.ajax
      url: api.host+url+'&client_id='+api.client_id+'&client_secret='+api.client_secret
      type: 'POST'
      dataType: 'json'
      success: (response) =>
        publishersBefore = V3RedroverWebsite.currentUser.get('followedPublishers')
        publishersAfter = publishersBefore
        
        if following
          publishersAfter.push(parseInt(@id))
        else
          publishersAfter = _.without(publishersBefore, parseInt(@id))
        
        V3RedroverWebsite.currentUser.set('followedPublishers', publishersAfter)
        
        @set 'following', following
      error: (response) =>
        alert('There was an error processing your request. Please try again later.')
        throw new Error(response.responseText)
}
