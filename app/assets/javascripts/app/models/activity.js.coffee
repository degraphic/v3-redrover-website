V3RedroverWebsite.Activity = DS.Model.extend
  activity_type: DS.attr('string')
  actionable_type: DS.attr('string')
  actionable: DS.attr('json')
  action_content: DS.attr('json')
  user: DS.attr('json')
  time_ago_in_words: DS.attr('string')

V3RedroverWebsite.Activity.reopenClass
  findAllUrl: 'activities'