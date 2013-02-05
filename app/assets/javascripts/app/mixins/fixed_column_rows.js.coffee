V3RedroverWebsite.FixedColumnRows = Ember.Mixin.create
	cols: 3
	rows: (->
    COLS = this.cols
    rows = Ember.A()
    row = null
    
    for item, index in this.toArray()
      if index % COLS == 0
        row = new Ember.A()
        rows.pushObject(row)
      row.pushObject(item)

    rows.toArray()
  ).property('@each')