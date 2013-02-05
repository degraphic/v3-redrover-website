class RRRestAdapter extends DS.RESTAdapter
    
  buildURL: (path) ->
    url = super
    @_addClientAuth(url)

  find: (store, type, id) ->
    root = @rootForType(type)
    @ajax @buildURL(root, id), "GET", {
      success: (json) ->
        @didFindRecord(store, type, json.data, id)
    }
  
  findMany: (store, type, ids) ->
    url = if type.findAllUrl
      @_addClientAuth [@url, type.findAllUrl].join('/')
    else
      root = @rootForType(type)
      @buildURL(root)
      
    ids = Ember.get(@, 'serializer').serializeIds(ids)
    @.ajax url, "GET", {
      data: {ids: ids},
      success: (json) ->
        @didFindMany(store, type, json.data)
    }
 
  findAssociation: (store, record, relationship, hash) ->
    this.ajax(hash.url, 'GET', {
      success: (data) ->
        loaded = store.loadMany relationship.type , data 
        store.materializeHasMany record, relationship.key, loaded.ids
    });

  extractHasMany: (type, hash, relationship) ->
    {url : my_has_many_url}

  createRecord: (store, type, model)->
    url = if type.saveUrl
      @_addClientAuth [@url, type.saveUrl.fmt(model.get("id")) ].join('/')
    else
      root = @rootForType(type)
      @buildURL(root)

    parameters = model.toData()
    parameters = jQuery.extend(parameters, model.get("data")) unless  $.isEmptyObject model.get("data")
    parameters = jQuery.extend(parameters, model.get("parameters")) unless  $.isEmptyObject model.get("parameters")

    $.each( parameters, (key, value)->
        delete parameters[key] if value is null
      )
      
    $.ajax  {
        data: $.param(parameters),
        type: "POST",
        url: url,
        dataType: 'json',
        success: (data)->
          model.set("createdResponse", data)
          store.didCreateRecord model, data
    }

  findQuery: (store, type, query, recordArray) ->
    url = if type.findAllUrl
      @_addClientAuth [@url, type.findAllUrl].join('/')
    else
      root = @rootForType(type)
      @buildURL(root)
    
    # Note: could be extended to use parent_ids array in order
    if query.parent_id
      url = @_replaceParentIds(url, query.parent_id)
      
    @.ajax url, "GET", {
      data: query,  
      success: (json) ->
        @didFindQuery(store, type, json.data, recordArray)
    }

  findAll: (store, type, since) ->
    url = if type.findAllUrl
      @_addClientAuth [@url, type.findAllUrl].join('/')
    else
      root = @rootForType(type)
      @buildURL(root)
    
    @ajax url, "GET", {
      data: @sinceQuery(since)
      success: (json) ->
        @didFindAll(store, type, json.data)
    }

  _addClientAuth: (url) ->
    api = V3RedroverWebsite.Config.api
    joiner = if /\?/.test(url) then '&' else '?'
    "#{url}#{joiner}client_id=#{api.client_id}&client_secret=#{api.client_secret}&auth_token=#{api.auth_token}"

  _replaceParentIds: (url, parent_id) ->
    url.replace('%@', parent_id)

  mapping:
    comments: V3RedroverWebsite.EventComment

V3RedroverWebsite.Store = DS.Store.extend {
  revision: 8
  adapter: RRRestAdapter.create {
    url: V3RedroverWebsite.Config.api.host
    plurals: {
      # Plurar index should be camelcase with the current model
      "category": "categories"
      "nearby": "nearby"
      "event_comment": "comments"
      "place_comment": "comments"
      "activity": "activities"
    }
  }
}