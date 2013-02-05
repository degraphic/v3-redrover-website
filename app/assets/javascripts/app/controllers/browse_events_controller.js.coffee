V3RedroverWebsite.BrowseEventsController = Ember.ArrayController.extend
  rows: (->
    COLS = 3
    rows = Ember.A()
    row = null
    
    for item, index in this.toArray()
      if index % COLS == 0
        row = new Ember.A()
        rows.pushObject(row)
      row.pushObject(item)

    rows.toArray()
  ).property('@each')
