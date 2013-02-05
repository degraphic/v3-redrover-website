V3RedroverWebsite.PersonalInformation = DS.Model.extend {
  first_name: DS.attr('string')
  last_name: DS.attr('string')
  bio: DS.attr('string')
  email: DS.attr('string')
}

V3RedroverWebsite.PersonalInformation.reopenClass {
  saveUrl: 'users/change_personal_info'
}