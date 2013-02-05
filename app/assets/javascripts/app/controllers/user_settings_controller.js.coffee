V3RedroverWebsite.UserSettingsController = Ember.Object.extend
  updatePersonalInformation: (personalInformationData, successCallback)->
    personalInformation= V3RedroverWebsite.PersonalInformation.createRecord {
      parameters:
        email: personalInformationData.email 
        last_name: personalInformationData.lastName 
        first_name: personalInformationData.firstName
        bio: personalInformationData.bio
        gender: personalInformationData.gender
        zipcode: personalInformationData.zipcode
    }

    that = @  
    personalInformation.didCreate = (model)->
      successCallback()

    personalInformation.store.commit()

  changePassword: (passwordData, successCallback)->
    password = V3RedroverWebsite.Password.createRecord(
        parameters:
          current_password: passwordData.current_password
          new_password: passwordData.new_password
          new_password_confirmation: passwordData.confirm_new_password
      )
    password.didCreate = (model)->
      successCallback(model)
    password.store.commit()

  savePrivacyOptions: (privacyOptions, successCallback)->
    userPrivacy = V3RedroverWebsite.UserPrivacy.createRecord (
      parameters:
        feeds_i_follow_privacy: privacyOptions.feedsPrivacy
        my_saved_events_privacy: privacyOptions.eventsPrivacy
        my_saved_places_privacy: privacyOptions.placesPrivacy
        people_i_follow_privacy: privacyOptions.followingPrivacy
        following_me_privacy: privacyOptions.followersPrivacy
        my_2_cent_privacy: "friends" #Compulsory in the API call
    )
    
    userPrivacy.didCreate = (model)->
      successCallback()

    userPrivacy.store.commit()