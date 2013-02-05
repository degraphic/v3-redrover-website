V3RedroverWebsite.UserPrivacy = DS.Model.extend {
  feeds_i_follow_privacy: DS.attr('string')
  people_i_follow_privacy: DS.attr('string')
  following_me_privacy: DS.attr('string')
  my_saved_places_privacy: DS.attr('string')
  my_saved_events_privacy: DS.attr('string')
  my_2_cent_privacy: DS.attr('string')
}

V3RedroverWebsite.UserPrivacy.reopenClass {
  saveUrl: 'users/change_user_privacy'
}
