# Custom transforms
DS.Transforms.reopen {
  json:
    fromData: (serialized) ->
      if serialized and $.isArray(serialized)
        Ember.Object.create(item) for item in serialized
      else if serialized
        Ember.Object.create(serialized) if serialized

    toData: (deserialized) ->
      deserialized
}
