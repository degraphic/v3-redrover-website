V3RedroverWebsite.Password = DS.Model.extend {
  current_password: DS.attr('string')
  new_password: DS.attr('string')
  new_password_confirmation: DS.attr('string')
}

V3RedroverWebsite.Password.reopenClass {
  saveUrl: 'users/change_password'
}
