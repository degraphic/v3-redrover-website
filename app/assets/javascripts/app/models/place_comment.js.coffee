V3RedroverWebsite.PlaceComment = DS.Model.extend {
  content: DS.attr('string')
  image_thumb: DS.attr('string')
  image_medium: DS.attr('string')
  time_ago_in_words: DS.attr('string')
  user: DS.attr("json")
}

V3RedroverWebsite.PlaceComment.reopenClass {
  findAllUrl: 'places/%@/comments'
  saveUrl: 'places/%@/add_comment'
}
