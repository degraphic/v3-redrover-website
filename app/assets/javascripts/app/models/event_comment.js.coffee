V3RedroverWebsite.EventComment = DS.Model.extend {
  content: DS.attr('string')
  image_thumb: DS.attr('string')
  image_medium: DS.attr('string')
  created_at: DS.attr('string')
  time_ago_in_words: DS.attr('string')
  user: DS.attr('json')
  
 
}

V3RedroverWebsite.EventComment.reopenClass {
  findAllUrl: 'events/%@/comments'
  saveUrl: 'events/%@/add_comment'
}
