V3RedroverWebsite.BrowsePublishersController = Ember.ArrayController.extend
  # Organize the publishers by categories

  categories: (->
    V3RedroverWebsite.PublisherCategory.find()
  ).property()
  
  categorizedPublishers: (->
    categoryHash = {}
    
    for publisher in this.toArray()
      publisher.get('categories').forEach (category) ->
        categoryHash[category.id] = new Ember.A() unless categoryHash[category.id]
        categoryHash[category.id].pushObject(publisher)

    result = Ember.A()
    @get('categories').forEach (category) =>
      if categoryHash[category.id]
        result.pushObject({
          category: category
          publishers: @publisherRows(categoryHash[category.id].toArray())
        })

    result.toArray()
  ).property('@categories', '@each')

  publisherRows: (publishers) ->
    COLS = 4
    rows = Ember.A()
    row = null

    for item, index in publishers
      if index % COLS == 0
        row = new Ember.A()
        rows.pushObject(row)
      row.pushObject(item)

    rows.toArray()
    